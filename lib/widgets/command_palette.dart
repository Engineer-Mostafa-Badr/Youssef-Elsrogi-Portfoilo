import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_state.dart';
import '../core/theme.dart';

class PaletteCommand {
  const PaletteCommand(this.icon, this.label, this.run);
  final IconData icon;
  final T label;
  final VoidCallback run;
}

Future<void> showCommandPalette(BuildContext context, List<PaletteCommand> commands) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (_) => _Palette(commands: commands),
  );
}

class _Palette extends StatefulWidget {
  const _Palette({required this.commands});
  final List<PaletteCommand> commands;

  @override
  State<_Palette> createState() => _PaletteState();
}

class _PaletteState extends State<_Palette> {
  final _query = TextEditingController();
  int _index = 0;

  List<PaletteCommand> _filtered(BuildContext context) {
    final q = _query.text.trim().toLowerCase();
    if (q.isEmpty) return widget.commands;
    return widget.commands.where((c) => c.label.en.toLowerCase().contains(q) || c.label.ar.contains(q)).toList();
  }

  void _run(PaletteCommand cmd) {
    Navigator.pop(context);
    cmd.run();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final items = _filtered(context);
    if (_index >= items.length) _index = items.isEmpty ? 0 : items.length - 1;

    return Align(
      alignment: const Alignment(0, -0.45),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 560,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: c.accent.withValues(alpha: 0.35)),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 60, offset: const Offset(0, 24))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CallbackShortcuts(
                bindings: {
                  const SingleActivator(LogicalKeyboardKey.arrowDown): () => setState(() => _index = (_index + 1).clamp(0, items.length - 1)),
                  const SingleActivator(LogicalKeyboardKey.arrowUp): () => setState(() => _index = (_index - 1).clamp(0, items.length - 1)),
                  const SingleActivator(LogicalKeyboardKey.enter): () {
                    if (items.isNotEmpty) _run(items[_index]);
                  },
                },
                child: TextField(
                  controller: _query,
                  autofocus: true,
                  onChanged: (_) => setState(() => _index = 0),
                  style: AppFonts.body(ar).copyWith(color: c.text, fontSize: 16),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded, color: c.accent),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('ESC', style: AppFonts.mono().copyWith(color: c.muted, fontSize: 11)),
                    ),
                    hintText: ar ? 'اكتب أمر أو دوّر…' : 'Type a command or search…',
                    hintStyle: AppFonts.body(ar).copyWith(color: c.muted),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
              ),
              Divider(height: 1, color: c.border),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 380),
                child: items.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(28),
                        child: Text(ar ? 'مفيش نتايج' : 'No results', style: AppFonts.body(ar).copyWith(color: c.muted)),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: items.length,
                        itemBuilder: (_, i) {
                          final cmd = items[i];
                          final sel = i == _index;
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => setState(() => _index = i),
                            child: GestureDetector(
                              onTap: () => _run(cmd),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                decoration: BoxDecoration(
                                  color: sel ? c.accent.withValues(alpha: 0.10) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(cmd.icon, size: 18, color: sel ? c.accent : c.muted),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        context.tr(cmd.label),
                                        style: AppFonts.body(ar).copyWith(color: sel ? c.text : c.text.withValues(alpha: 0.8), fontSize: 14.5),
                                      ),
                                    ),
                                    if (sel) Icon(Icons.keyboard_return_rounded, size: 16, color: c.accent),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Divider(height: 1, color: c.border),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      '↑↓ ${ar ? 'تنقّل' : 'navigate'}   ↵ ${ar ? 'تنفيذ' : 'run'}',
                      style: AppFonts.mono().copyWith(color: c.muted, fontSize: 11),
                    ),
                    const Spacer(),
                    Text('Ctrl / ⌘ + K', style: AppFonts.mono().copyWith(color: c.accent, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
