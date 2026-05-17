import 'package:url_launcher/url_launcher.dart';

Future<void> abrirLink(String valor) async {
  final uri = Uri.parse(valor);
  await launchUrl(
    uri,
    mode: LaunchMode.platformDefault,
    webOnlyWindowName: '_blank',
  );
}
