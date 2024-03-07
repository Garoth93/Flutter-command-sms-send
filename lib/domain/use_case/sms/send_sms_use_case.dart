import 'package:url_launcher/url_launcher.dart';

class SendSmsUseCase {
  void sendSMS(String number, String msg) async {
    final Uri url =
        Uri(scheme: 'sms', path: number, queryParameters: {'body': msg});
    await launchUrl(url);
  }
}
