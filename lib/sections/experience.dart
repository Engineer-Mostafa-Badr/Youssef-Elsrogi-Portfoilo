import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/common.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: 3,
            eyebrow: T('Experience', 'الخبرات'),
            title: T('Where I’ve shipped', 'اشتغلت فين'),
            subtitle: T(
              'Two backend roles, one thread: multi-tenant systems that other teams build on.',
              'دورين Backend والخيط واحد: سيستمات multi-tenant الفرق التانية بتبني عليها.',
            ),
          ),
          for (var i = 0; i < jobs.length; i++)
            Reveal(
              delay: Duration(milliseconds: 100 * i),
              child: _TimelineItem(job: jobs[i], last: i == jobs.length - 1),
            ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.job, required this.last});
  final Job job;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final m = context.isMobile;
    final current = job.end == null;
    final rail = m ? 22.0 : 36.0;
    final range = '${monthYear(job.start, ar)} – ${current ? context.pick('Present', 'حتى الآن') : monthYear(job.end!, ar)}';

    // The rail is a Positioned child so it stretches with the card's real height
    // (no IntrinsicHeight, which mis-measures wrapped text and overflowed).
    return Stack(
      children: [
        if (!last)
          PositionedDirectional(
            start: rail / 2 - 1,
            top: 44,
            bottom: 0,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [c.accent.withValues(alpha: 0.55), c.border],
                ),
              ),
            ),
          ),
        PositionedDirectional(
          start: rail / 2 - 7,
          top: 26,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: current ? c.accentGradient : null,
              color: current ? null : c.bg,
              border: Border.all(color: c.accent, width: 2),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: rail + (m ? 10 : 18), bottom: 24),
          child: HoverCard(
            padding: EdgeInsets.all(m ? 20 : 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.tr(job.role),
                          style: AppFonts.heading(ar).copyWith(fontSize: m ? 18 : 21, color: c.text),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          job.company,
                          style: AppFonts.body(ar).copyWith(fontSize: 15, fontWeight: FontWeight.w600, color: c.accent),
                        ),
                      ],
                    ),
                    if (current) TagChip(context.pick('Current role', 'الدور الحالي'), accent: true, small: true),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 18,
                  runSpacing: 6,
                  children: [
                    _Meta(icon: Icons.location_on_outlined, text: context.tr(job.location)),
                    _Meta(icon: Icons.calendar_today_outlined, text: range),
                    _Meta(icon: Icons.schedule_rounded, text: duration(job.start, job.end, ar)),
                  ],
                ),
                const SizedBox(height: 18),
                Text(context.tr(job.summary), style: AppFonts.body(ar).copyWith(color: c.text.withValues(alpha: 0.88), fontSize: 15, height: 1.7)),
                const SizedBox(height: 14),
                for (final b in job.bullets)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(width: 10, height: 1.5, color: c.accent),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(context.tr(b), style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 14.5, height: 1.7)),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 10),
                Wrap(spacing: 8, runSpacing: 8, children: [for (final t in job.tech) TagChip(t, small: true)]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: c.muted),
        const SizedBox(width: 6),
        Flexible(
          child: Text(text, style: AppFonts.body(context.isAr).copyWith(color: c.muted, fontSize: 13)),
        ),
      ],
    );
  }
}
