import 'package:url_launcher/url_launcher.dart';

Future<void> abrirLink(String valor) async {
  final uri = Uri.parse(valor);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }
}
