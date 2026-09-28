import 'dart:async';

import 'package:flutter/material.dart';

import '../core/theme.dart';

enum _Kind { info, ok, json }

class _Line {
  const _Line(this.text, [this.kind = _Kind.info]);
  final String text;
  final _Kind kind;
}

class _Script {
  const _Script(this.command, this.output);
  final String command;
  final List<_Line> output;
}

/// Illustrative terminal that types backend commands and their output on loop.
const _scripts = [
  _Script('curl -X POST /api/v1/webhooks/zid -d \'{"event":"order.create"}\'', [
    _Line('→ Resolving tenant from store scope…'),
    _Line('→ order.create  ⇒  Actions\\Order\\Create'),
    _Line('✓ Job queued on horizon:zoho-sync', _Kind.ok),
    _Line('{ "status": 202, "synced": true }', _Kind.json),
  ]),
  _Script('php artisan tenants:run reports:aggregate', [
    _Line('criterion → axis → perspective → department'),
    _Line('✓ Cycle results aggregated', _Kind.ok),
    _Line('✓ PDF + Excel exported → s3://reports/', _Kind.ok),
    _Line('{ "state": "Closed", "notified": true }', _Kind.json),
  ]),
  _Script('php artisan test --filter=TenantIsolation', [
    _Line('PASS  Tests\\Feature\\TenantIsolationTest'),
    _Line('PASS  Tests\\Feature\\WebhookSignatureTest'),
    _Line('PASS  Tests\\Feature\\OAuthTokenRefreshTest'),
    _Line('✓ All tests passed', _Kind.ok),
  ]),
];

class TerminalCard extends StatefulWidget {
  const TerminalCard({super.key, this.compact = false});
  final bool compact;

  @override
  State<TerminalCard> createState() => _TerminalCardState();
}

class _TerminalCardState extends State<TerminalCard> {
  int _script = 0;
  int _chars = 0;
  int _lines = 0;
  bool _cursor = true;
  Timer? _typing;
  Timer? _blink;

  @override
  void initState() {
    super.initState();
    _blink = Timer.periodic(const Duration(milliseconds: 530), (_) => setState(() => _cursor = !_cursor));
    _start();
  }

  void _start() {
    _chars = 0;
    _lines = 0;
    _typing?.cancel();
    _typing = Timer.periodic(const Duration(milliseconds: 32), (t) {
      final s = _scripts[_script];
      if (_chars < s.command.length) {
        setState(() => _chars++);
        return;
      }
      t.cancel();
      _revealOutput();
    });
  }

  Future<void> _revealOutput() async {
    final s = _scripts[_script];
    for (var i = 0; i < s.output.length; i++) {
      await Future.delayed(const Duration(milliseconds: 380));
      if (!mounted) return;
      setState(() => _lines = i + 1);
    }
    await Future.delayed(const Duration(milliseconds: 2800));
    if (!mounted) return;
    setState(() => _script = (_script + 1) % _scripts.length);
    _start();
  }

  @override
  void dispose() {
    _typing?.cancel();
    _blink?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = _scripts[_script];
    final mono = AppFonts.mono().copyWith(fontSize: widget.compact ? 11.5 : 12.5, height: 1.7);
    Color colorFor(_Kind k) => switch (k) {
      _Kind.info => const Color(0xFF8E979F),
      _Kind.ok => AppColors.dark.success,
      _Kind.json => AppColors.dark.accent,
    };

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D0F12).withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.45), blurRadius: 40, offset: const Offset(0, 20))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.07))),
              ),
              child: Row(
                children: [
                  for (final col in const [Color(0xFFFF5F57), Color(0xFFFEBC2E), Color(0xFF28C840)])
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(color: col, shape: BoxShape.circle),
                    ),
                  const SizedBox(width: 8),
                  Text('youssef@api:~/backend', style: AppFonts.mono().copyWith(fontSize: 11, color: const Color(0xFF8E979F))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(widget.compact ? 14 : 18),
              child: SizedBox(
                height: widget.compact ? 170 : 160,
                width: double.infinity,
                // Long commands wrap on narrow screens; scroll-clip instead of overflowing.
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '\$ ',
                              style: mono.copyWith(color: AppColors.dark.accent, fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: s.command.substring(0, _chars),
                              style: mono.copyWith(color: const Color(0xFFF3EEE8)),
                            ),
                            TextSpan(
                              text: _chars < s.command.length || _lines == s.output.length ? (_cursor ? '▋' : ' ') : '',
                              style: mono.copyWith(color: AppColors.dark.accent),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      for (var i = 0; i < _lines; i++)
                        Text(
                          s.output[i].text,
                          style: mono.copyWith(color: colorFor(s.output[i].kind)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
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
