import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/common.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    return ContentBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: 6,
            eyebrow: T('Education', 'التعليم'),
            title: T('Always learning', 'بتعلّم على طول'),
            subtitle: T(
              'Formal training that grounds my engineering practice — while working full-time.',
              'التدريب الأكاديمي اللي بيأسّس شغلي الهندسي — جنب الشغل الـ full-time.',
            ),
          ),
          ResponsiveGrid(
            columns: context.isMobile ? 1 : 2,
            children: [
              for (var i = 0; i < education.length; i++)
                Reveal(
                  delay: Duration(milliseconds: 90 * i),
                  child: HoverCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconBadge(education[i].icon, size: 52),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TagChip(context.tr(education[i].badge), accent: true, small: true),
                              const SizedBox(height: 12),
                              Text(context.tr(education[i].title), style: AppFonts.heading(ar).copyWith(fontSize: 18, color: c.text, height: 1.3)),
                              const SizedBox(height: 8),
                              Text(
                                context.tr(education[i].place),
                                style: AppFonts.body(ar).copyWith(color: c.text.withValues(alpha: 0.8), fontSize: 14.5),
                              ),
                              const SizedBox(height: 6),
                              Text(context.tr(education[i].date), style: AppFonts.mono().copyWith(color: c.muted, fontSize: 12.5)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
