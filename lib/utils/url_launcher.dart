import 'package:url_launcher/url_launcher.dart';

void launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

void sendEmail(String email) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  if (!await launchUrl(emailUri)) {
    throw 'Could not send email to $email';
  }
}

