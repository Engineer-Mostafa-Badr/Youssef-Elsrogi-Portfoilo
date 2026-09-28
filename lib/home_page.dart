import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/app_state.dart';
import 'core/links.dart';
import 'core/theme.dart';
import 'data/portfolio_data.dart';
import 'sections/about.dart';
import 'sections/contact.dart';
import 'sections/education.dart';
import 'sections/experience.dart';
import 'sections/hero.dart';
import 'sections/process.dart';
import 'sections/projects.dart';
import 'sections/skills.dart';
import 'widgets/command_palette.dart';
import 'widgets/common.dart';

enum Section { home, about, skills, experience, projects, contact }

const sectionLabels = {
  Section.home: T('Home', 'الرئيسية'),
  Section.about: T('About', 'نبذة'),
  Section.skills: T('Skills', 'المهارات'),
  Section.experience: T('Experience', 'الخبرات'),
  Section.projects: T('Projects', 'المشاريع'),
  Section.contact: T('Contact', 'تواصل'),
};

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _sc = ScrollController();
  final _keys = {for (final s in Section.values) s: GlobalKey()};
  final _progress = ValueNotifier<double>(0);
  final _scrolled = ValueNotifier<bool>(false);
  final _active = ValueNotifier<Section>(Section.home);
  final _pointer = ValueNotifier<Offset?>(null);

  static const _konami = [
    LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.arrowRight,
    LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.arrowRight,
    LogicalKeyboardKey.keyB,
    LogicalKeyboardKey.keyA,
  ];
  int _konamiIndex = 0;
  bool _paletteOpen = false;

  @override
  void initState() {
    super.initState();
    _sc.addListener(_onScroll);
    HardwareKeyboard.instance.addHandler(_onKey);
    WidgetsBinding.instance.addPostFrameCallback((_) => _applyDeepLink());
  }

  /// Supports shareable links like `?s=projects&lang=ar&theme=light`.
  void _applyDeepLink() {
    final q = Uri.base.queryParameters;
    final app = AppScope.read(context);
    if (q['lang'] == 'ar' && !app.ar) app.toggleLocale();
    if (q['theme'] == 'light' && app.dark) app.toggleTheme();
    final target = Section.values.where((s) => s.name == q['s']).firstOrNull;
    if (target != null) {
      Future.delayed(const Duration(milliseconds: 400), () {
        if (!mounted) return;
        final ctx = _keys[target]!.currentContext;
        if (ctx != null && ctx.mounted) Scrollable.ensureVisible(ctx);
      });
    }
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_onKey);
    _sc.dispose();
    super.dispose();
  }

  void _onScroll() {
    final p = _sc.position;
    _progress.value = p.maxScrollExtent <= 0 ? 0 : (p.pixels / p.maxScrollExtent).clamp(0, 1);
    _scrolled.value = p.pixels > 24;

    var current = Section.home;
    for (final s in Section.values) {
      final ctx = _keys[s]!.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top <= 220) current = s;
    }
    if (p.pixels >= p.maxScrollExtent - 4) current = Section.contact;
    _active.value = current;
  }

  bool _onKey(KeyEvent e) {
    if (e is! KeyDownEvent) return false;
    final k = HardwareKeyboard.instance;
    if (e.logicalKey == LogicalKeyboardKey.keyK && (k.isControlPressed || k.isMetaPressed)) {
      _openPalette();
      return true;
    }
    if (e.logicalKey == _konami[_konamiIndex]) {
      _konamiIndex++;
      if (_konamiIndex == _konami.length) {
        _konamiIndex = 0;
        _showSecret();
      }
    } else {
      _konamiIndex = e.logicalKey == _konami.first ? 1 : 0;
    }
    return false;
  }

  void scrollTo(Section s) {
    final ctx = _keys[s]!.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 800), curve: Curves.easeInOutCubic);
  }

  Future<void> _openPalette() async {
    if (_paletteOpen) return;
    _paletteOpen = true;
    final app = AppScope.read(context);
    await showCommandPalette(context, [
      for (final s in Section.values)
        PaletteCommand(Icons.arrow_forward_rounded, T('Go to ${sectionLabels[s]!.en}', 'روح لـ ${sectionLabels[s]!.ar}'), () => scrollTo(s)),
      PaletteCommand(Icons.contrast_rounded, const T('Toggle light / dark theme', 'تبديل الثيم فاتح / غامق'), app.toggleTheme),
      PaletteCommand(Icons.translate_rounded, const T('التبديل إلى العربية', 'Switch to English'), app.toggleLocale),
      PaletteCommand(Icons.download_rounded, const T('Download CV', 'تحميل الـ CV'), () => Links.open(Links.cv)),
      PaletteCommand(Icons.copy_rounded, const T('Copy email address', 'نسخ الإيميل'), () {
        Links.copy(Links.email);
        _toast(const T('Email copied ✓', 'الإيميل اتنسخ ✓'));
      }),
      PaletteCommand(Icons.mail_rounded, const T('Send an email', 'ابعت إيميل'), () => Links.open(Links.mail())),
      PaletteCommand(Icons.chat_rounded, const T('Chat on WhatsApp', 'كلّمني واتساب'), () => Links.open(Links.whatsapp(app.ar))),
      PaletteCommand(Icons.code_rounded, const T('Open GitHub', 'افتح GitHub'), () => Links.open(Links.github)),
      PaletteCommand(Icons.work_rounded, const T('Open LinkedIn', 'افتح LinkedIn'), () => Links.open(Links.linkedin)),
    ]);
    _paletteOpen = false;
  }

  void _toast(T msg) {
    final c = context.c;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        width: 320,
        backgroundColor: c.surfaceHi,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: c.accent.withValues(alpha: 0.4)),
        ),
        content: Text(context.tr(msg), style: AppFonts.body(context.isAr).copyWith(color: c.text)),
      ),
    );
  }

  void _showSecret() {
    final c = context.c;
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: c.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: c.accent.withValues(alpha: 0.5)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🚀', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              GradientText(context.pick('You found the secret!', 'لقيت السر!'), style: AppFonts.heading(context.isAr).copyWith(fontSize: 24)),
              const SizedBox(height: 10),
              Text(
                context.pick(
                  "If you know the Konami code, you're my kind of dev. Let's talk. 😄",
                  'لو إنت عارف الـ Konami code يبقى إنت من نوعي. يلا نتكلم 😄',
                ),
                textAlign: TextAlign.center,
                style: AppFonts.body(context.isAr).copyWith(color: c.muted, height: 1.6),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: context.pick("Let's talk", 'يلا نتكلم'),
                icon: Icons.chat_rounded,
                onTap: () {
                  Navigator.pop(ctx);
                  scrollTo(Section.contact);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final dark = AppScope.of(context).dark;
    return Scaffold(
      body: MouseRegion(
        onHover: (e) => _pointer.value = e.position,
        onExit: (_) => _pointer.value = null,
        child: Stack(
          children: [
            // Studio backdrop — spotlight top-left, soft warm bounce bottom-right.
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.7, -0.9),
                    radius: 1.3,
                    colors: [
                      c.spotlight.withValues(alpha: dark ? 0.55 : 0.8),
                      c.bg,
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(1.0, 1.0),
                    radius: 1.1,
                    colors: [
                      c.accentDeep.withValues(alpha: dark ? 0.14 : 0.10),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(child: CustomPaint(painter: BackdropPainter(c, dark))),
            // Warm light that trails the cursor (desktop only).
            if (context.isDesktop)
              Positioned.fill(
                child: IgnorePointer(
                  child: ValueListenableBuilder<Offset?>(
                    valueListenable: _pointer,
                    builder: (_, pos, __) => CustomPaint(painter: SpotlightPainter(pos, c.accent.withValues(alpha: dark ? 0.06 : 0.10))),
                  ),
                ),
              ),
            SingleChildScrollView(
              controller: _sc,
              child: Column(
                children: [
                  KeyedSubtree(
                    key: _keys[Section.home],
                    child: HeroSection(onProjects: () => scrollTo(Section.projects), onContact: () => scrollTo(Section.contact)),
                  ),
                  Reveal(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Marquee(items: marqueeItems),
                    ),
                  ),
                  KeyedSubtree(key: _keys[Section.about], child: const AboutSection()),
                  KeyedSubtree(key: _keys[Section.skills], child: const SkillsSection()),
                  KeyedSubtree(key: _keys[Section.experience], child: const ExperienceSection()),
                  const ProcessSection(),
                  KeyedSubtree(key: _keys[Section.projects], child: const ProjectsSection()),
                  const EducationSection(),
                  KeyedSubtree(
                    key: _keys[Section.contact],
                    child: ContactSection(onCopied: () => _toast(const T('Copied ✓', 'اتنسخ ✓'))),
                  ),
                  Footer(onTop: () => scrollTo(Section.home)),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _NavBar(scrolled: _scrolled, active: _active, onNav: scrollTo, onPalette: _openPalette),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ValueListenableBuilder<double>(
                valueListenable: _progress,
                builder: (_, v, __) => Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: FractionallySizedBox(
                    widthFactor: v,
                    child: Container(height: 2.5, decoration: BoxDecoration(gradient: c.accentGradient)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar({required this.scrolled, required this.active, required this.onNav, required this.onPalette});
  final ValueNotifier<bool> scrolled;
  final ValueNotifier<Section> active;
  final void Function(Section) onNav;
  final VoidCallback onPalette;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final app = AppScope.of(context);
    final desktop = context.isDesktop;
    return ValueListenableBuilder<bool>(
      valueListenable: scrolled,
      builder: (context, isScrolled, _) => ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: isScrolled ? 16 : 0, sigmaY: isScrolled ? 16 : 0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 72,
            decoration: BoxDecoration(
              color: isScrolled ? c.bg.withValues(alpha: 0.72) : Colors.transparent,
              border: Border(bottom: BorderSide(color: isScrolled ? c.border : Colors.transparent)),
            ),
            padding: EdgeInsets.symmetric(horizontal: context.isMobile ? 16 : 40),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: Row(
                  children: [
                    _Logo(onTap: () => onNav(Section.home)),
                    const Spacer(),
                    if (desktop)
                      ValueListenableBuilder<Section>(
                        valueListenable: active,
                        builder: (_, a, __) => Row(
                          children: [
                            for (final s in Section.values) _NavLink(label: context.tr(sectionLabels[s]!), active: a == s, onTap: () => onNav(s)),
                          ],
                        ),
                      ),
                    if (desktop) const SizedBox(width: 12),
                    if (!context.isMobile) _IconAction(icon: Icons.keyboard_command_key_rounded, tooltip: 'Ctrl + K', onTap: onPalette),
                    _TextAction(
                      label: app.ar ? 'EN' : 'ع',
                      tooltip: context.pick('التبديل إلى العربية', 'Switch to English'),
                      onTap: app.toggleLocale,
                    ),
                    _IconAction(
                      icon: app.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      tooltip: context.pick(app.dark ? 'Light mode' : 'Dark mode', app.dark ? 'الوضع الفاتح' : 'الوضع الغامق'),
                      onTap: app.toggleTheme,
                    ),
                    if (desktop) ...[
                      const SizedBox(width: 10),
                      PrimaryButton(label: context.pick('Hire me', 'وظّفني'), dense: true, onTap: () => onNav(Section.contact)),
                    ],
                    if (!desktop) _IconAction(icon: Icons.menu_rounded, tooltip: context.pick('Menu', 'القائمة'), onTap: () => _openMenu(context)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openMenu(BuildContext context) {
    final c = context.c;
    showModalBottomSheet(
      context: context,
      backgroundColor: c.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: c.border, borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(height: 16),
              for (final s in Section.values)
                ListTile(
                  title: Text(
                    context.tr(sectionLabels[s]!),
                    style: AppFonts.body(context.isAr).copyWith(color: c.text, fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  trailing: Icon(Icons.arrow_forward_rounded, color: c.accent, size: 18),
                  onTap: () {
                    Navigator.pop(ctx);
                    onNav(s);
                  },
                ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: context.pick('Hire me', 'وظّفني'),
                  onTap: () {
                    Navigator.pop(ctx);
                    onNav(Section.contact);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(gradient: c.accentGradient, borderRadius: BorderRadius.circular(10)),
              child: Text(
                'YE',
                style: AppFonts.heading(
                  false,
                ).copyWith(color: const Color(0xFF14171B), fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: -0.5),
              ),
            ),
            if (context.width >= 360) const SizedBox(width: 10),
            if (context.width >= 360)
              Text(context.pick('Youssef Elsrogi', 'يوسف السروجي'), style: AppFonts.heading(context.isAr).copyWith(color: c.text, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.label, required this.active, required this.onTap});
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final on = widget.active || _hover;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppFonts.body(context.isAr).copyWith(color: on ? c.text : c.muted, fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                height: 2,
                width: widget.active ? 18 : 0,
                decoration: BoxDecoration(gradient: c.accentGradient, borderRadius: BorderRadius.circular(2)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  const _IconAction({required this.icon, required this.tooltip, required this.onTap});
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, size: 20, color: c.text.withValues(alpha: 0.85)),
      ),
    );
  }
}

class _TextAction extends StatelessWidget {
  const _TextAction({required this.label, required this.tooltip, required this.onTap});
  final String label;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          width: 36,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: c.border),
          ),
          child: Text(
            label,
            style: AppFonts.body(label != 'EN').copyWith(color: c.text, fontWeight: FontWeight.w700, fontSize: 13),
          ),
        ),
      ),
    );
  }
}
