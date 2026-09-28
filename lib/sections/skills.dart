import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/common.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final cols = switch (context.screen) {
      ScreenSize.mobile => 1,
      ScreenSize.tablet => 2,
      ScreenSize.desktop => 3,
    };

    return ContentBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: 2,
            eyebrow: T('Skills', 'المهارات'),
            title: T('The toolbox', 'الأدوات اللي بشتغل بيها'),
            subtitle: T(
              'What I reach for to ship secure, scalable, maintainable backends.',
              'اللي بستخدمه عشان أشحن Backend آمن وقابل للتوسع وسهل الصيانة.',
            ),
          ),
          ResponsiveGrid(
            columns: cols,
            spacing: 16,
            children: [
              for (var i = 0; i < skillGroups.length; i++)
                Reveal(
                  delay: Duration(milliseconds: 60 * i),
                  child: HoverCard(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: cols == 1 ? 0 : 190),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(skillGroups[i].icon, color: c.accent, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(context.tr(skillGroups[i].title), style: AppFonts.heading(ar).copyWith(fontSize: 16.5, color: c.text)),
                              ),
                              Text('${skillGroups[i].items.length}'.padLeft(2, '0'), style: AppFonts.mono().copyWith(color: c.muted, fontSize: 11.5)),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Wrap(spacing: 7, runSpacing: 7, children: [for (final s in skillGroups[i].items) TagChip(s, small: true)]),
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
