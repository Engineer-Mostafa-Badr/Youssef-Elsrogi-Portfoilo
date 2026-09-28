import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/common.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final m = context.isMobile;
    final desktop = context.isDesktop;

    final story = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: context.pick('I build the part of the product nobody sees — ', 'ببني الجزء اللي محدش بيشوفه في المنتج — ')),
                TextSpan(
                  text: context.pick('and everybody depends on.', 'واللي الكل معتمد عليه.'),
                  style: TextStyle(color: c.accent),
                ),
              ],
            ),
            style: AppFonts.heading(ar).copyWith(fontSize: m ? 30 : 46, height: 1.2, color: c.text, letterSpacing: ar ? 0 : -0.8),
          ),
        ),
        const SizedBox(height: 26),
        Reveal(
          delay: const Duration(milliseconds: 80),
          child: Text(
            context.tr(aboutCards[0].body),
            style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: m ? 15 : 16.5, height: 1.8),
          ),
        ),
        const SizedBox(height: 16),
        Reveal(
          delay: const Duration(milliseconds: 140),
          child: Text(
            context.tr(aboutCards[1].body),
            style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: m ? 15 : 16.5, height: 1.8),
          ),
        ),
        const SizedBox(height: 28),
        Reveal(
          delay: const Duration(milliseconds: 200),
          child: Wrap(spacing: 8, runSpacing: 8, children: [for (final s in personalSkills) TagChip(context.tr(s), small: true)]),
        ),
      ],
    );

    final facts = Reveal(
      delay: const Duration(milliseconds: 120),
      child: Container(
        decoration: BoxDecoration(
          color: c.surface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: c.border),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Row(
                children: [
                  Text(
                    context.pick('Quick facts', 'معلومات سريعة'),
                    style: AppFonts.body(ar).copyWith(color: c.text, fontWeight: FontWeight.w700, fontSize: 14.5),
                  ),
                  const Spacer(),
                  Text('profile.json', style: AppFonts.mono().copyWith(color: c.muted, fontSize: 11.5)),
                ],
              ),
            ),
            for (final f in aboutFacts)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: c.border)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: m ? 92 : 110,
                      child: Text(context.tr(f.label), style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 13.5)),
                    ),
                    Expanded(
                      child: Text(
                        context.tr(f.value),
                        style: AppFonts.body(ar).copyWith(color: c.text, fontSize: 14, fontWeight: FontWeight.w500, height: 1.45),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );

    return ContentBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(child: Eyebrow(context.tr(const T('About', 'نبذة')), index: 1)),
          SizedBox(height: m ? 20 : 28),
          desktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 7, child: story),
                    const SizedBox(width: 64),
                    Expanded(flex: 5, child: facts),
                  ],
                )
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [story, const SizedBox(height: 36), facts]),
        ],
      ),
    );
  }
}
