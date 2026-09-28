import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../core/app_state.dart';
import '../core/theme.dart';

/// Centers content with a max width and responsive side padding.
class ContentBox extends StatelessWidget {
  const ContentBox({super.key, required this.child, this.vertical = 96});
  final Widget child;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    final h = context.isMobile ? 20.0 : 40.0;
    final v = context.isMobile ? vertical * 0.7 : vertical;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
      child: Center(
        child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1180), child: child),
      ),
    );
  }
}

/// Fades + slides its child in the first time it scrolls into view.
class Reveal extends StatefulWidget {
  const Reveal({super.key, required this.child, this.delay = Duration.zero, this.offset = 28});
  final Widget child;
  final Duration delay;
  final double offset;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  static int _counter = 0;
  final _id = 'reveal-${_counter++}';
  bool _shown = false;

  void _onVisibility(VisibilityInfo info) {
    if (_shown || info.visibleFraction < 0.08) return;
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _shown = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(_id),
      onVisibilityChanged: _onVisibility,
      child: AnimatedOpacity(
        opacity: _shown ? 1 : 0,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _shown ? Offset.zero : Offset(0, widget.offset / 400),
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, required this.style, this.textAlign});
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (r) => context.c.accentGradient.createShader(r),
      child: Text(text, style: style, textAlign: textAlign),
    );
  }
}

class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.index});
  final String text;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final mono = AppFonts.mono().copyWith(fontSize: 12, fontWeight: FontWeight.w600);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (index != null) ...[Text(index!.toString().padLeft(2, '0'), style: mono.copyWith(color: c.accent)), const SizedBox(width: 10)],
        Container(width: 24, height: 1, color: c.accent.withValues(alpha: 0.6)),
        const SizedBox(width: 10),
        Text(
          context.isAr ? text : text.toUpperCase(),
          style: (context.isAr ? AppFonts.body(true).copyWith(fontSize: 13, fontWeight: FontWeight.w600) : mono).copyWith(
            color: c.muted,
            letterSpacing: context.isAr ? 0 : 2,
          ),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.eyebrow, required this.title, this.subtitle, this.index});
  final T eyebrow;
  final T title;
  final T? subtitle;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final m = context.isMobile;
    return Reveal(
      child: Padding(
        padding: EdgeInsets.only(bottom: m ? 32 : 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Eyebrow(context.tr(eyebrow), index: index),
            const SizedBox(height: 16),
            Text(
              context.tr(title),
              style: AppFonts.heading(ar).copyWith(fontSize: m ? 30 : 44, color: c.text, height: 1.15, letterSpacing: ar ? 0 : -1.2),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 14),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  context.tr(subtitle!),
                  style: AppFonts.body(ar).copyWith(fontSize: m ? 14.5 : 16, color: c.muted, height: 1.65),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Card with a subtle lift + accent border on hover.
class HoverCard extends StatefulWidget {
  const HoverCard({super.key, required this.child, this.onTap, this.padding = const EdgeInsets.all(24), this.radius = 18});
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final double radius;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hover ? -4 : 0, 0),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: _hover ? c.surfaceHi : c.surface,
            borderRadius: BorderRadius.circular(widget.radius),
            border: Border.all(color: _hover ? c.accent.withValues(alpha: 0.35) : c.border),
            boxShadow: [if (_hover) BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 30, offset: const Offset(0, 14))],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip(this.label, {super.key, this.accent = false, this.small = false});
  final String label;
  final bool accent;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final color = accent ? c.accent : c.steel;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: small ? 9 : 12, vertical: small ? 4 : 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: accent ? 0.10 : 0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Text(
        label,
        style: AppFonts.body(
          context.isAr,
        ).copyWith(fontSize: small ? 11.5 : 12.5, color: accent ? c.accent : c.text.withValues(alpha: 0.85), fontWeight: FontWeight.w500),
      ),
    );
  }
}

class IconBadge extends StatelessWidget {
  const IconBadge(this.icon, {super.key, this.size = 44});
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: c.accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(size * 0.28),
        border: Border.all(color: c.accent.withValues(alpha: 0.30)),
      ),
      child: Icon(icon, color: c.accent, size: size * 0.5),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({super.key, required this.label, required this.onTap, this.icon, this.dense = false});
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool dense;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final m = context.isMobile;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: widget.dense
              ? const EdgeInsets.symmetric(horizontal: 18, vertical: 10)
              : EdgeInsets.symmetric(horizontal: m ? 20 : 26, vertical: m ? 13 : 15),
          decoration: BoxDecoration(
            gradient: c.accentGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [if (_hover) BoxShadow(color: c.accent.withValues(alpha: 0.25), blurRadius: 24, offset: const Offset(0, 8))],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[Icon(widget.icon, size: 18, color: const Color(0xFF14171B)), const SizedBox(width: 8)],
              Text(
                widget.label,
                style: AppFonts.body(
                  context.isAr,
                ).copyWith(color: const Color(0xFF14171B), fontWeight: FontWeight.w700, fontSize: widget.dense ? 13.5 : (m ? 14 : 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GhostButton extends StatefulWidget {
  const GhostButton({super.key, required this.label, required this.onTap, this.icon});
  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  State<GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<GhostButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final m = context.isMobile;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: m ? 20 : 26, vertical: m ? 13 : 15),
          decoration: BoxDecoration(
            color: _hover ? c.accent.withValues(alpha: 0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _hover ? c.accent : c.text.withValues(alpha: 0.25), width: 1.3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[Icon(widget.icon, size: 18, color: _hover ? c.accent : c.text), const SizedBox(width: 8)],
              Text(
                widget.label,
                style: AppFonts.body(context.isAr).copyWith(color: _hover ? c.accent : c.text, fontWeight: FontWeight.w600, fontSize: m ? 14 : 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Lays children out in a responsive grid of equal-width cells (no scrolling).
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({super.key, required this.children, required this.columns, this.spacing = 20});
  final List<Widget> children;
  final int columns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final w = (box.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [for (final ch in children) SizedBox(width: w, child: ch)],
        );
      },
    );
  }
}

/// Faint blueprint grid + studio spotlights, echoing the portrait's lighting.
class BackdropPainter extends CustomPainter {
  BackdropPainter(this.c, this.dark);
  final AppColors c;
  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = (dark ? Colors.white : Colors.black).withValues(alpha: dark ? 0.025 : 0.035)
      ..strokeWidth = 1;
    const step = 56.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  @override
  bool shouldRepaint(covariant BackdropPainter old) => old.dark != dark;
}

/// Slow, endless strip of text items with faded edges.
class Marquee extends StatefulWidget {
  const Marquee({super.key, required this.items, this.speed = 40});
  final List<String> items;
  final double speed; // px per second

  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> with SingleTickerProviderStateMixin {
  late final _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 60))..repeat();
  final _key = GlobalKey();
  double _stripWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  void _measure() {
    final box = _key.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !mounted) return;
    setState(() {
      _stripWidth = box.size.width;
      _ctrl.duration = Duration(milliseconds: (_stripWidth / widget.speed * 1000).round());
      _ctrl.repeat();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    Widget strip({Key? key}) => Row(
      key: key,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final item in widget.items) ...[
          Text(
            item,
            style: AppFonts.heading(false).copyWith(color: c.text.withValues(alpha: 0.55), fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: c.accent.withValues(alpha: 0.7), shape: BoxShape.circle),
            ),
          ),
        ],
      ],
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (r) => const LinearGradient(
          colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent],
          stops: [0, 0.12, 0.88, 1],
        ).createShader(r),
        child: ClipRect(
          child: SizedBox(
            height: 32,
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, child) => OverflowBox(
                maxWidth: double.infinity,
                alignment: Alignment.centerLeft,
                child: Transform.translate(offset: Offset(-_ctrl.value * _stripWidth, 0), child: child),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  strip(key: _key),
                  strip(),
                  strip(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Soft warm light that follows the cursor — the portrait's studio lamp, on the page.
class SpotlightPainter extends CustomPainter {
  SpotlightPainter(this.pos, this.color);
  final Offset? pos;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (pos == null) return;
    const r = 420.0;
    final paint = Paint()
      ..shader = RadialGradient(colors: [color, color.withValues(alpha: 0)]).createShader(Rect.fromCircle(center: pos!, radius: r));
    canvas.drawCircle(pos!, r, paint);
  }

  @override
  bool shouldRepaint(covariant SpotlightPainter old) => old.pos != pos || old.color != color;
}
