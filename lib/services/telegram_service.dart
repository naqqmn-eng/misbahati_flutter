import 'package:url_launcher/url_launcher.dart';

class TelegramService {
  static final Uri link = Uri.parse('https://t.me/U_S5S');
  static Future<void> open() async {
    if (!await launchUrl(link, mode: LaunchMode.externalApplication)) {
      await launchUrl(link, mode: LaunchMode.platformDefault);
    }
  }
}
