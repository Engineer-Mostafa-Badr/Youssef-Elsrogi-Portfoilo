import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/common.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final cols = switch (context.screen) {
      ScreenSize.mobile => 1,
      ScreenSize.tablet => 2,
      ScreenSize.desktop => 4,
    };
    return ContentBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: 4,
            eyebrow: T('Process', 'طريقة الشغل'),
            title: T('From schema to production', 'من الـ schema للـ production'),
            subtitle: T(
              'The rhythm I follow on every endpoint, integration, and product.',
              'الإيقاع اللي بمشي عليه في كل endpoint وكل integration وكل منتج.',
            ),
          ),
          ResponsiveGrid(
            columns: cols,
            spacing: 16,
            children: [
              for (var i = 0; i < processSteps.length; i++)
                Reveal(
                  delay: Duration(milliseconds: 90 * i),
                  child: HoverCard(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: cols == 1 ? 0 : 260),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Outlined step number — quiet, editorial.
                              Text(
                                (i + 1).toString().padLeft(2, '0'),
                                style: AppFonts.heading(false).copyWith(
                                  fontSize: 46,
                                  height: 1,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1.2
                                    ..color = c.accent.withValues(alpha: 0.7),
                                ),
                              ),
                              const Spacer(),
                              Icon(processSteps[i].icon, color: c.muted, size: 20),
                            ],
                          ),
                          const SizedBox(height: 26),
                          Text(context.tr(processSteps[i].title), style: AppFonts.heading(ar).copyWith(fontSize: 19, color: c.text)),
                          const SizedBox(height: 10),
                          Text(context.tr(processSteps[i].body), style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 14, height: 1.65)),
                        ],
                      ),
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
