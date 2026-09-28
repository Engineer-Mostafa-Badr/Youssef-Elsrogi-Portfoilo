import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/links.dart';
import '../core/theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/common.dart';
import '../widgets/terminal.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onProjects, required this.onContact});
  final VoidCallback onProjects;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final desktop = context.isDesktop;
    final text = _HeroText(onProjects: onProjects);
    const visual = _HeroVisual();

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: desktop ? math.max(screenH - 70, 720) : 0),
      child: ContentBox(
        vertical: 0,
        child: Padding(
          padding: EdgeInsets.only(top: desktop ? 120 : 110, bottom: desktop ? 48 : 24),
          child: desktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 11, child: text),
                    const SizedBox(width: 64),
                    const Expanded(flex: 9, child: visual),
                  ],
                )
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [text, const SizedBox(height: 56), visual]),
        ),
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText({required this.onProjects});
  final VoidCallback onProjects;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final m = context.isMobile;
    final nameSize = m ? 52.0 : 88.0;
    final nameStyle = AppFonts.heading(ar).copyWith(fontSize: nameSize, height: ar ? 1.25 : 0.98, letterSpacing: ar ? 0 : -3.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Reveal(child: _Availability()),
        const SizedBox(height: 28),
        Reveal(
          delay: const Duration(milliseconds: 80),
          child: Text(
            context.pick('MID-LEVEL BACKEND DEVELOPER — LARAVEL / PHP', 'مطوّر Backend متوسط الخبرة — Laravel / PHP'),
            style:
                (ar
                        ? AppFonts.body(true).copyWith(fontSize: 15, fontWeight: FontWeight.w600)
                        : AppFonts.mono().copyWith(fontSize: 12.5, letterSpacing: 2))
                    .copyWith(color: c.muted),
          ),
        ),
        const SizedBox(height: 18),
        Reveal(
          delay: const Duration(milliseconds: 160),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.pick('Youssef', 'يوسف'), style: nameStyle.copyWith(color: c.text)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GradientText(context.pick('Elsrogi', 'السروجي'), style: nameStyle),
                  Text('.', style: nameStyle.copyWith(color: c.accent)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),
        const Reveal(delay: Duration(milliseconds: 240), child: _TypedRole()),
        const SizedBox(height: 22),
        Reveal(
          delay: const Duration(milliseconds: 320),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540),
            child: Text(
              context.tr(Profile.tagline),
              style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: m ? 15 : 17, height: 1.75),
            ),
          ),
        ),
        const SizedBox(height: 34),
        Reveal(
          delay: const Duration(milliseconds: 400),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              PrimaryButton(label: context.pick('View my work', 'شوف شغلي'), icon: Icons.arrow_outward_rounded, onTap: onProjects),
              GhostButton(label: context.pick('Download CV', 'تحميل الـ CV'), icon: Icons.download_rounded, onTap: () => Links.open(Links.cv)),
            ],
          ),
        ),
        SizedBox(height: m ? 40 : 52),
        const Reveal(delay: Duration(milliseconds: 480), child: _Stats()),
      ],
    );
  }
}

class _Availability extends StatefulWidget {
  const _Availability();

  @override
  State<_Availability> createState() => _AvailabilityState();
}

class _AvailabilityState extends State<_Availability> with SingleTickerProviderStateMixin {
  late final _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))..repeat();

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: AnimatedBuilder(
            animation: _pulse,
            builder: (_, __) => Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 6 + 10 * _pulse.value,
                  height: 6 + 10 * _pulse.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: c.success.withValues(alpha: 0.35 * (1 - _pulse.value)),
                  ),
                ),
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: c.success),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            context.pick('Available for backend roles & freelance', 'متاح لوظائف Backend وشغل Freelance'),
            style: AppFonts.body(context.isAr).copyWith(color: c.text.withValues(alpha: 0.85), fontSize: 13.5, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class _TypedRole extends StatefulWidget {
  const _TypedRole();

  @override
  State<_TypedRole> createState() => _TypedRoleState();
}

class _TypedRoleState extends State<_TypedRole> {
  int _i = 0;
  int _n = 0;
  bool _deleting = false;
  Timer? _t;

  @override
  void initState() {
    super.initState();
    _schedule(const Duration(milliseconds: 600));
  }

  void _schedule(Duration d) => _t = Timer(d, _step);

  void _step() {
    if (!mounted) return;
    final full = context.tr(Profile.typedRoles[_i]);
    var next = Duration(milliseconds: _deleting ? 30 : 65);
    setState(() {
      if (!_deleting) {
        if (_n < full.length) {
          _n++;
        } else {
          _deleting = true;
          next = const Duration(milliseconds: 1900);
        }
      } else if (_n > 0) {
        _n--;
      } else {
        _deleting = false;
        _i = (_i + 1) % Profile.typedRoles.length;
        next = const Duration(milliseconds: 300);
      }
    });
    _schedule(next);
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final full = context.tr(Profile.typedRoles[_i]);
    final shown = full.substring(0, _n.clamp(0, full.length));
    final size = context.isMobile ? 15.0 : 18.0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: c.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: c.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '~/',
            style: AppFonts.mono().copyWith(color: c.accent, fontSize: size, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              '$shown▍',
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: (context.isAr ? AppFonts.body(true) : AppFonts.mono()).copyWith(color: c.text, fontSize: size, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats();

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final m = context.isMobile;
    final items = <Widget>[];
    for (var i = 0; i < heroStats.length; i++) {
      final s = heroStats[i];
      if (i > 0) {
        items.add(
          Container(
            width: 1,
            height: 44,
            color: c.border,
            margin: EdgeInsets.symmetric(horizontal: m ? 16 : 28),
          ),
        );
      }
      items.add(
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  s.value,
                  style: AppFonts.heading(false).copyWith(fontSize: m ? 28 : 36, height: 1, color: c.text),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.tr(s.label),
                style: AppFonts.body(context.isAr).copyWith(color: c.muted, fontSize: m ? 12 : 13, height: 1.3),
              ),
            ],
          ),
        ),
      );
    }
    return Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: items);
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual();

  @override
  Widget build(BuildContext context) {
    final desktop = context.isDesktop;
    final m = context.isMobile;
    final photoH = desktop ? 560.0 : (m ? 420.0 : 520.0);

    if (desktop) {
      return Reveal(
        delay: const Duration(milliseconds: 200),
        child: SizedBox(
          height: photoH + 70,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(left: 40, right: 0, top: 0, child: _TiltPhoto(height: photoH)),
              const Positioned(right: -14, top: 36, child: _NowCard()),
              const Positioned(left: -24, right: 90, bottom: 0, child: TerminalCard()),
            ],
          ),
        ),
      );
    }

    return Reveal(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  _TiltPhoto(height: photoH),
                  const PositionedDirectional(end: 12, top: 16, child: _NowCard()),
                ],
              ),
              Transform.translate(
                offset: const Offset(0, -44),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TerminalCard(compact: m),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Portrait with a gentle 3D tilt that follows the pointer.
class _TiltPhoto extends StatefulWidget {
  const _TiltPhoto({required this.height});
  final double height;

  @override
  State<_TiltPhoto> createState() => _TiltPhotoState();
}

class _TiltPhotoState extends State<_TiltPhoto> {
  Offset _tilt = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return LayoutBuilder(
      builder: (context, box) {
        return MouseRegion(
          onHover: (e) =>
              setState(() => _tilt = Offset((e.localPosition.dx / box.maxWidth - 0.5) * 2, (e.localPosition.dy / widget.height - 0.5) * 2)),
          onExit: (_) => setState(() => _tilt = Offset.zero),
          child: TweenAnimationBuilder<Offset>(
            tween: Tween(end: _tilt),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            builder: (_, t, child) => Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0012)
                ..rotateX(-t.dy * 0.05)
                ..rotateY(t.dx * 0.05),
              child: child,
            ),
            child: Container(
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: c.text.withValues(alpha: 0.10)),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.45), blurRadius: 50, offset: const Offset(0, 30))],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(23),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset('assets/images/youssef.jpg', fit: BoxFit.cover, alignment: const Alignment(0, -0.4)),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.5, 1],
                          colors: [Colors.transparent, Color(0xD90B0B0E)],
                        ),
                      ),
                    ),
                    // Hairline accent frame inset, like a print mat.
                    Positioned.fill(
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFD9B48F).withValues(alpha: 0.18)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// "Currently at" card floating on the portrait.
class _NowCard extends StatefulWidget {
  const _NowCard();

  @override
  State<_NowCard> createState() => _NowCardState();
}

class _NowCardState extends State<_NowCard> with SingleTickerProviderStateMixin {
  late final _a = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);

  @override
  void dispose() {
    _a.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    return AnimatedBuilder(
      animation: _a,
      builder: (_, child) => Transform.translate(offset: Offset(0, -5 * Curves.easeInOut.transform(_a.value)), child: child),
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 16, 10),
        decoration: BoxDecoration(
          color: c.surface.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: c.border),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 24, offset: const Offset(0, 10))],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(gradient: c.accentGradient, borderRadius: BorderRadius.circular(9)),
              child: const Icon(Icons.work_rounded, size: 17, color: Color(0xFF14171B)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.pick('Currently at', 'حالياً في'), style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 11)),
                Text(
                  'Apps Bunches',
                  style: AppFonts.body(false).copyWith(color: c.text, fontSize: 13.5, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
