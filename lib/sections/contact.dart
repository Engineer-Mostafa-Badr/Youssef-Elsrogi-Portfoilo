import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/app_state.dart';
import '../core/links.dart';
import '../core/theme.dart';
import '../widgets/common.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.onCopied});
  final VoidCallback onCopied;

  @override
  Widget build(BuildContext context) {
    final desktop = context.isDesktop;
    return ContentBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Reveal(child: _CtaBanner()),
          const SizedBox(height: 96),
          const SectionHeader(
            index: 7,
            eyebrow: T('Contact', 'تواصل'),
            title: T('Get in touch', 'كلّمني'),
            subtitle: T(
              'Open to backend roles, freelance projects, and collaborations — reach out on whichever channel suits you.',
              'متاح لوظائف Backend ومشاريع Freelance وأي تعاون — كلّمني على أي وسيلة تريحك.',
            ),
          ),
          desktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _Channels(onCopied: onCopied)),
                    const SizedBox(width: 28),
                    const Expanded(
                      flex: 6,
                      child: Reveal(delay: Duration(milliseconds: 120), child: _MessageForm()),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _Channels(onCopied: onCopied),
                    const SizedBox(height: 24),
                    const Reveal(child: _MessageForm()),
                  ],
                ),
        ],
      ),
    );
  }
}

class _CtaBanner extends StatelessWidget {
  const _CtaBanner();

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final m = context.isMobile;
    return Container(
      padding: const EdgeInsets.all(1.2),
      decoration: BoxDecoration(gradient: c.accentGradient, borderRadius: BorderRadius.circular(28)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: m ? 24 : 56, vertical: m ? 40 : 64),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          gradient: RadialGradient(center: const Alignment(-0.8, -1), radius: 1.6, colors: [c.spotlight, c.surface]),
        ),
        child: Column(
          children: [
            Text(
              context.pick('HAVE A BACKEND TO BUILD?', 'عندك Backend محتاج يتبني؟'),
              style:
                  (ar
                          ? AppFonts.body(true).copyWith(fontSize: 14, fontWeight: FontWeight.w600)
                          : AppFonts.mono().copyWith(fontSize: 12, letterSpacing: 2.5))
                      .copyWith(color: c.accent),
            ),
            const SizedBox(height: 16),
            GradientText(
              context.pick("Let's build something solid together", 'يلا نبني حاجة متينة سوا'),
              textAlign: TextAlign.center,
              style: AppFonts.heading(ar).copyWith(fontSize: m ? 28 : 44, height: 1.2, letterSpacing: ar ? 0 : -1),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Text(
                context.pick(
                  'From multi-tenant SaaS to Zid, Zoho & payment integrations — if it needs a reliable Laravel backend, let’s talk.',
                  'من SaaS متعدد الـ tenants لحد integrations مع Zid و Zoho وبوابات الدفع — لو محتاج Backend بـ Laravel يعتمد عليه، يلا نتكلم.',
                ),
                textAlign: TextAlign.center,
                style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: m ? 14.5 : 16.5, height: 1.7),
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 14,
              runSpacing: 14,
              children: [
                PrimaryButton(label: context.pick('Email me', 'ابعتلي إيميل'), icon: Icons.mail_rounded, onTap: () => Links.open(Links.mail())),
                GhostButton(label: 'WhatsApp', icon: Icons.chat_rounded, onTap: () => Links.open(Links.whatsapp(ar))),
                GhostButton(label: context.pick('Download CV', 'تحميل الـ CV'), icon: Icons.download_rounded, onTap: () => Links.open(Links.cv)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Channel {
  const _Channel(this.icon, this.label, this.value, this.url, {this.copy});
  final FaIconData icon;
  final T label;
  final String value;
  final String url;
  final String? copy;
}

class _Channels extends StatelessWidget {
  const _Channels({required this.onCopied});
  final VoidCallback onCopied;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final channels = [
      _Channel(FontAwesomeIcons.envelope, const T('Email', 'الإيميل'), Links.email, Links.mail(), copy: Links.email),
      _Channel(FontAwesomeIcons.phone, const T('Call me', 'كلّمني'), Links.phoneDisplay, 'tel:${Links.phone}', copy: Links.phone),
      _Channel(FontAwesomeIcons.whatsapp, const T('WhatsApp', 'واتساب'), Links.phoneDisplay, Links.whatsapp(ar)),
      _Channel(FontAwesomeIcons.linkedinIn, const T('LinkedIn', 'LinkedIn'), 'engineer-youssef-elsrogi', Links.linkedin),
      _Channel(FontAwesomeIcons.github, const T('GitHub', 'GitHub'), 'YoussefEhabElsrogi', Links.github),
      _Channel(
        FontAwesomeIcons.locationDot,
        const T('Based in', 'المكان'),
        ar ? 'الغربية، مصر · متاح Remote' : 'Gharbia, Egypt · Remote-friendly',
        '',
      ),
    ];
    return Column(
      children: [
        for (var i = 0; i < channels.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Reveal(
              delay: Duration(milliseconds: 50 * i),
              child: HoverCard(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                radius: 14,
                onTap: channels[i].url.isEmpty ? null : () => Links.open(channels[i].url),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: c.accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(11)),
                      child: FaIcon(channels[i].icon, size: 17, color: c.accent),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.tr(channels[i].label), style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 12)),
                          const SizedBox(height: 2),
                          Directionality(
                            textDirection: channels[i].url.isEmpty ? Directionality.of(context) : TextDirection.ltr,
                            child: Text(
                              channels[i].value,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.body(ar).copyWith(color: c.text, fontSize: 14.5, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (channels[i].copy != null)
                      IconButton(
                        tooltip: context.pick('Copy', 'نسخ'),
                        onPressed: () {
                          Links.copy(channels[i].copy!);
                          onCopied();
                        },
                        icon: Icon(Icons.copy_rounded, size: 17, color: c.muted),
                      )
                    else if (channels[i].url.isNotEmpty)
                      Icon(Icons.arrow_outward_rounded, size: 18, color: c.muted),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _MessageForm extends StatefulWidget {
  const _MessageForm();

  @override
  State<_MessageForm> createState() => _MessageFormState();
}

class _MessageFormState extends State<_MessageForm> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _msg = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _msg.dispose();
    super.dispose();
  }

  void _send() {
    if (!_form.currentState!.validate()) return;
    final body = '${_msg.text.trim()}\n\n— ${_name.text.trim()} (${_email.text.trim()})';
    Links.open(Links.mail(subject: 'Portfolio message from ${_name.text.trim()}', body: body));
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;

    InputDecoration deco(String hint, IconData? icon) => InputDecoration(
      hintText: hint,
      hintStyle: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 14),
      prefixIcon: icon == null ? null : Icon(icon, size: 19, color: c.muted),
      filled: true,
      fillColor: c.bg2.withValues(alpha: 0.6),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: c.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: c.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: c.accent, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE57373)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE57373), width: 1.4),
      ),
    );
    final style = AppFonts.body(ar).copyWith(color: c.text, fontSize: 14.5);
    String? required(String? v) => (v == null || v.trim().isEmpty) ? context.pick('Required', 'مطلوب') : null;

    return Container(
      padding: EdgeInsets.all(context.isMobile ? 20 : 30),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.border),
      ),
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.pick('Or drop me a quick message', 'أو ابعتلي رسالة سريعة'),
              style: AppFonts.heading(ar).copyWith(fontSize: 20, color: c.text),
            ),
            const SizedBox(height: 6),
            Text(
              context.pick('It opens your email app with everything pre-filled.', 'هتفتح برنامج الإيميل عندك والرسالة جاهزة.'),
              style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 13.5),
            ),
            const SizedBox(height: 22),
            TextFormField(
              controller: _name,
              style: style,
              validator: required,
              decoration: deco(context.pick('Your name', 'اسمك'), Icons.person_outline_rounded),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _email,
              style: style,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                final r = required(v);
                if (r != null) return r;
                return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v!.trim()) ? null : context.pick('Invalid email', 'إيميل مش صحيح');
              },
              decoration: deco(context.pick('Your email', 'إيميلك'), Icons.alternate_email_rounded),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _msg,
              style: style,
              validator: required,
              minLines: 5,
              maxLines: 8,
              decoration: deco(context.pick('Tell me about the role or project…', 'احكيلي عن الوظيفة أو المشروع…'), null),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(label: context.pick('Send message', 'ابعت الرسالة'), icon: Icons.send_rounded, onTap: _send),
            ),
          ],
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key, required this.onTop});
  final VoidCallback onTop;

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final ar = context.isAr;
    final m = context.isMobile;
    final brand = Column(
      crossAxisAlignment: m ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(gradient: c.accentGradient, borderRadius: BorderRadius.circular(9)),
              child: Text(
                'YE',
                style: AppFonts.heading(false).copyWith(color: const Color(0xFF14171B), fontSize: 13, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(width: 10),
            Text(context.pick('Youssef Elsrogi', 'يوسف السروجي'), style: AppFonts.heading(ar).copyWith(color: c.text, fontSize: 16)),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          context.pick('Backend Laravel Developer building secure, scalable APIs.', 'مطوّر Backend بـ Laravel ببني APIs آمنة وقابلة للتوسع.'),
          textAlign: m ? TextAlign.center : TextAlign.start,
          style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 13.5),
        ),
      ],
    );

    final right = Column(
      crossAxisAlignment: m ? CrossAxisAlignment.center : CrossAxisAlignment.end,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final s in [
              (FontAwesomeIcons.github, Links.github),
              (FontAwesomeIcons.linkedinIn, Links.linkedin),
              (FontAwesomeIcons.whatsapp, Links.whatsapp(ar)),
              (FontAwesomeIcons.envelope, Links.mail()),
            ])
              IconButton(
                onPressed: () => Links.open(s.$2),
                icon: FaIcon(s.$1, size: 16, color: c.muted),
              ),
            const SizedBox(width: 6),
            TextButton.icon(
              onPressed: onTop,
              icon: Icon(Icons.arrow_upward_rounded, size: 16, color: c.accent),
              label: Text(
                context.pick('Back to top', 'لأعلى'),
                style: AppFonts.body(ar).copyWith(color: c.accent, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '© ${DateTime.now().year} ${context.pick('Youssef Elsrogi', 'يوسف السروجي')} · ${context.pick('Crafted with Flutter', 'معمول بـ Flutter')} · Ctrl + K',
          textAlign: m ? TextAlign.center : TextAlign.end,
          style: AppFonts.body(ar).copyWith(color: c.muted, fontSize: 12.5),
        ),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: c.border)),
        color: c.bg.withValues(alpha: 0.6),
      ),
      child: ContentBox(
        vertical: 36,
        child: m
            ? Column(children: [brand, const SizedBox(height: 22), right])
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: brand),
                  right,
                ],
              ),
      ),
    );
  }
}
