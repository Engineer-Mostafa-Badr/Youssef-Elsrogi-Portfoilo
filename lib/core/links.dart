import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Links {
  static const email = 'youssefelsrogi1@gmail.com';
  static const phone = '+201124684262';
  static const phoneDisplay = '+20 112 468 4262';
  static const linkedin = 'https://www.linkedin.com/in/engineer-youssef-elsrogi/';
  static const github = 'https://github.com/YoussefEhabElsrogi';
  static const cv = 'cv/Youssef-Elsrogi-CV.pdf';

  static String whatsapp(bool ar) {
    final msg = ar
        ? 'أهلاً يوسف، شفت البورتفوليو بتاعك وحابب نتكلم عن فرصة / مشروع Backend.'
        : "Hi Youssef, I saw your portfolio and I'd like to talk about a backend role / project.";
    return 'https://wa.me/201124684262?text=${Uri.encodeComponent(msg)}';
  }

  static String mail({String subject = 'Backend opportunity', String body = ''}) =>
      'mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';

  static Future<void> open(String url) async {
    final uri = url.startsWith('http') || url.startsWith('mailto:') || url.startsWith('tel:') ? Uri.parse(url) : Uri.base.resolve(url);
    await launchUrl(uri, webOnlyWindowName: url.startsWith('http') || !url.contains(':') ? '_blank' : '_self');
  }

  static Future<void> copy(String text) => Clipboard.setData(ClipboardData(text: text));
}
