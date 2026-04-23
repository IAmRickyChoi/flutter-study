import 'package:url_launcher/url_launcher.dart';

class SnsLinks {
  final String google = "www.google.com";

  void googleLink() => _launchURL(google);

  Future<void> _launchURL(String? urlString) async {
    if (urlString == null) return;

    final Uri url = Uri.parse(
      urlString.startsWith('http') ? urlString : 'https://$urlString',
    );

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
