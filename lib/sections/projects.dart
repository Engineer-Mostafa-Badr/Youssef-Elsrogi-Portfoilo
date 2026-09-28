import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/app_state.dart';
import '../core/links.dart';
import '../core/theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/common.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cols = switch (context.screen) {
      ScreenSize.mobile => 1,
      ScreenSize.tablet => 2,
      ScreenSize.desktop => 3,
    };
    final featured = projects.where((p) => p.featured).toList();
    final more = projects.where((p) => !p.featured && p.cat != ProjectCat.openSource).toList();
    final repos = projects.where((p) => p.cat == ProjectCat.openSource).toList();

    return ContentBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            index: 5,
            eyebrow: T('Selected work', 'شغل مختار'),
            title: T('Things I’ve built', 'حاجات بنيتها'),
            subtitle: T(
              'Production SaaS, integrations, and enterprise systems. Open any project to see how it’s wired.',
              'SaaS في الإنتاج، integrations، وسيستمات enterprise. افتح أي مشروع وشوف متوصّل إزاي من جوه.',
            ),
          ),
          ResponsiveGrid(
            columns: cols,
            spacing: 18,
            children: [
              for (var i = 0; i < featured.length; i++)
                Reveal(
                  delay: Duration(milliseconds: 80 * i),
                  child: _ProjectCard(project: featured[i]),
                ),
            ],
          ),
          const SizedBox(height: 56),
          Reveal(child: _SubHeading(context.pick('Also shipped', 'مشاريع تانية اتسلّمت'))),
          const SizedBox(height: 18),
          ResponsiveGrid(
            columns: cols,
            spacing: 14,
            children: [
              for (var i = 0; i < more.length; i++)
                Reveal(
                  delay: Duration(milliseconds: 60 * i),
                  child: _CompactCard(project: more[i]),
                ),
            ],
          ),
          const SizedBox(height: 56),
          Reveal(child: _SubHeading(context.pick('Open source', 'Open source'), trailing: 'github.com/YoussefEhabElsrogi')),
          const SizedBox(height: 8),
          for (var i = 0; i < repos.length; i++)
            Reveal(
              delay: Duration(milliseconds: 50 * i),
              child: _RepoRow(project: repos[i]),
            ),
        ],
      ),
    );
  }
}

class _SubHeading extends StatelessWidget {
  const _SubHeading(this.text, {this.trailing});
  final String text;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Row(
      children: [
        Text(text, style: AppFonts.heading(context.isAr).copyWith(fontSize: 20, color: c.text)),
        const SizedBox(width: 16),
        Expanded(child: Container(height: 1, color: c.border)),
        if (trailing != null && !context.isMobile) ...[
          const SizedBox(width: 16),
          Text(trailing!, style: AppFonts.mono().copyWith(color: c.muted, fontSize: 12)),
        ],
      ],
    );
  }
}

class _CompactCard extends StatelessWidget {
  const _CompactCard({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final p = project;
    return HoverCard(
      padding: const EdgeInsets.all(20),
      radius: 16,
      onTap: () => showProjectDetails(context, p),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconBadge(p.icon, size: 40),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.company.toUpperCase(), style: AppFonts.mono().copyWith(color: c.accent, fontSize: 10.5, letterSpacing: 1.4)),
                const SizedBox(height: 4),
                Text(
                  context.tr(p.title),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.heading(ar).copyWith(fontSize: 15.5, color: c.text),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 42,
                  child: Text(
                    context.tr(p.short),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 13, height: 1.55),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.north_east_rounded, size: 16, color: c.muted),
        ],
      ),
    );
  }
}

class _RepoRow extends StatefulWidget {
  const _RepoRow({required this.project});
  final Project project;

  @override
  State<_RepoRow> createState() => _RepoRowState();
}

class _RepoRowState extends State<_RepoRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final m = context.isMobile;
    final p = widget.project;
    final name = p.repo!.split('/').last;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => Links.open(p.repo!),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: _hover ? 14 : 4),
          decoration: BoxDecoration(
            color: _hover ? c.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border(bottom: BorderSide(color: _hover ? Colors.transparent : c.border)),
          ),
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.github, size: 18, color: _hover ? c.accent : c.muted),
              const SizedBox(width: 16),
              Expanded(
                child: m
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: AppFonts.mono().copyWith(color: c.text, fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(context.tr(p.short), style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 13)),
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(
                            width: 260,
                            child: Text(
                              name,
                              style: AppFonts.mono().copyWith(color: c.text, fontSize: 14.5, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              context.tr(p.short),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 14),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(p.tech.first, style: AppFonts.mono().copyWith(color: c.muted, fontSize: 12)),
                        ],
                      ),
              ),
              const SizedBox(width: 16),
              AnimatedSlide(
                duration: const Duration(milliseconds: 200),
                offset: Offset(_hover ? 0.2 : 0, 0),
                child: Icon(Icons.north_east_rounded, size: 18, color: _hover ? c.accent : c.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final p = project;
    final live = p.cat != ProjectCat.openSource;
    return HoverCard(
      padding: EdgeInsets.zero,
      onTap: () => showProjectDetails(context, p),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover: a tiny architecture preview instead of screenshots.
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [c.surfaceHi, c.bg2, c.accentDeep.withValues(alpha: 0.25)],
              ),
              border: Border(bottom: BorderSide(color: c.border)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
                    child: CustomPaint(painter: BackdropPainter(c, true)),
                  ),
                ),
                PositionedDirectional(top: 18, start: 18, child: IconBadge(p.icon, size: 46)),
                PositionedDirectional(
                  top: 20,
                  end: 18,
                  child: _StatusPill(label: context.tr(p.status), live: live),
                ),
                Positioned(
                  left: 18,
                  right: 18,
                  bottom: 18,
                  child: ShaderMask(
                    // Fade the chain out at the edge instead of hard-clipping it.
                    shaderCallback: (r) =>
                        const LinearGradient(colors: [Colors.white, Colors.white, Colors.transparent], stops: [0, 0.82, 1]).createShader(r),
                    blendMode: BlendMode.dstIn,
                    child: FlowDiagram(nodes: p.flow, compact: true),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.company.toUpperCase(), style: AppFonts.mono().copyWith(color: c.accent, fontSize: 11, letterSpacing: 1.5)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 48,
                  child: Text(
                    context.tr(p.title),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.heading(ar).copyWith(fontSize: 18, color: c.text, height: 1.3),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 48,
                  child: Text(
                    context.tr(p.short),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 14, height: 1.6),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 28,
                  child: ClipRect(child: Wrap(spacing: 6, runSpacing: 6, children: [for (final t in p.tech.take(4)) TagChip(t, small: true)])),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Text(
                      context.pick('View details', 'التفاصيل'),
                      style: AppFonts.body(ar).copyWith(color: c.accent, fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.arrow_forward_rounded, size: 16, color: c.accent),
                    const Spacer(),
                    if (p.repo != null) FaIcon(FontAwesomeIcons.github, size: 16, color: c.muted),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.live});
  final String label;
  final bool live;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final color = live ? c.success : c.steel;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: c.bg.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppFonts.body(context.isAr).copyWith(color: c.text, fontSize: 11.5, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/// Nodes connected by arrows; a highlight "packet" travels along the chain.
class FlowDiagram extends StatefulWidget {
  const FlowDiagram({super.key, required this.nodes, this.compact = false});
  final List<String> nodes;
  final bool compact;

  @override
  State<FlowDiagram> createState() => _FlowDiagramState();
}

class _FlowDiagramState extends State<FlowDiagram> {
  int _active = 0;
  Timer? _t;

  @override
  void initState() {
    super.initState();
    _t = Timer.periodic(Duration(milliseconds: widget.compact ? 1100 : 850), (_) {
      if (mounted) setState(() => _active = (_active + 1) % widget.nodes.length);
    });
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final compact = widget.compact;
    final items = <Widget>[];
    for (var i = 0; i < widget.nodes.length; i++) {
      final on = i == _active;
      items.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 12, vertical: compact ? 5 : 9),
          decoration: BoxDecoration(
            color: on ? c.accent.withValues(alpha: 0.16) : c.bg.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(compact ? 7 : 10),
            border: Border.all(color: on ? c.accent : c.border),
            boxShadow: [if (on) BoxShadow(color: c.accent.withValues(alpha: 0.3), blurRadius: 14)],
          ),
          child: Text(
            widget.nodes[i],
            style: AppFonts.mono().copyWith(
              fontSize: compact ? 10 : 12,
              color: on ? c.accent : c.text.withValues(alpha: 0.85),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
      if (i < widget.nodes.length - 1) {
        items.add(
          Icon(
            Icons.arrow_forward_rounded,
            size: compact ? 12 : 16,
            color: c.accent.withValues(alpha: i == _active ? 1 : 0.4),
          ),
        );
      }
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: compact
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: [for (final w in items) Padding(padding: const EdgeInsets.only(right: 5), child: w)],
              ),
            )
          : Wrap(spacing: 8, runSpacing: 10, crossAxisAlignment: WrapCrossAlignment.center, children: items),
    );
  }
}

void showProjectDetails(BuildContext context, Project p) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.6),
    builder: (_) => _ProjectDialog(project: p),
  );
}

class _ProjectDialog extends StatelessWidget {
  const _ProjectDialog({required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final m = context.isMobile;
    final p = project;

    Widget label(String en, String a) => Padding(padding: const EdgeInsets.only(top: 28, bottom: 14), child: Eyebrow(context.pick(en, a)));

    return Dialog(
      backgroundColor: c.surface,
      insetPadding: EdgeInsets.symmetric(horizontal: m ? 12 : 40, vertical: m ? 24 : 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: c.accent.withValues(alpha: 0.3)),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 880),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(m ? 22 : 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconBadge(p.icon, size: m ? 46 : 56),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.company.toUpperCase(), style: AppFonts.mono().copyWith(color: c.accent, fontSize: 11.5, letterSpacing: 1.5)),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(end: 36),
                              child: Text(
                                context.tr(p.title),
                                style: AppFonts.heading(ar).copyWith(fontSize: m ? 21 : 27, color: c.text, height: 1.25),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _StatusPill(label: context.tr(p.status), live: p.cat != ProjectCat.openSource),
                                TagChip(context.tr(projectCatLabels[p.cat]!), accent: true, small: true),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(context.tr(p.concept), style: AppFonts.body(ar).copyWith(color: c.text.withValues(alpha: 0.88), fontSize: 15.5, height: 1.75)),
                  label('Architecture flow', 'مسار المعمارية'),
                  _Panel(child: FlowDiagram(nodes: p.flow)),
                  if (p.stateMachine != null) ...[
                    label('Workflow state machine', 'الـ State machine بتاعة الـ workflow'),
                    _Panel(child: FlowDiagram(nodes: p.stateMachine!)),
                  ],
                  if (p.aggregation != null) ...[label('Result aggregation', 'تجميع النتايج'), _Panel(child: FlowDiagram(nodes: p.aggregation!))],
                  if (p.subProjects != null) ...[
                    label('Systems', 'السيستمات'),
                    Wrap(spacing: 10, runSpacing: 10, children: [for (final s in p.subProjects!) TagChip(s, accent: true)]),
                  ],
                  label('Highlights', 'أبرز النقاط'),
                  for (final h in p.highlights)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Icon(Icons.check_circle_rounded, size: 18, color: c.accent),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(context.tr(h), style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 14.5, height: 1.7)),
                          ),
                        ],
                      ),
                    ),
                  label('Tech stack', 'التقنيات'),
                  Wrap(spacing: 8, runSpacing: 8, children: [for (final t in p.tech) TagChip(t)]),
                  if (p.repo != null) ...[
                    const SizedBox(height: 28),
                    PrimaryButton(label: context.pick('View Repo', 'افتح الـ Repo'), icon: Icons.code_rounded, onTap: () => Links.open(p.repo!)),
                  ],
                ],
              ),
            ),
            PositionedDirectional(
              top: 14,
              end: 14,
              child: IconButton(
                tooltip: context.pick('Close', 'إغلاق'),
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close_rounded, color: c.muted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.bg2.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.border),
      ),
      child: child,
    );
  }
}
