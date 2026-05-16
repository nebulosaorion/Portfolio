import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dados/biografia.dart';
import '../tema.dart';
import 'compartilhado.dart';

class SecaoSobre extends StatelessWidget {
  const SecaoSobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Cores.slate900.withAlpha(128),
      child: ContainerSecao(
        filho: Column(
          children: [
            const TituloSecao(texto: 'Sobre Mim'),
            const SizedBox(height: 32),
            CartaoEscuro(
              filho: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: biografiaSobre
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _Biografia(
                          texto: item.texto,
                          destaque: item.destaque,
                          complemento: item.complemento,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Biografia extends StatelessWidget {
  final String texto;
  final String? destaque;
  final String? complemento;

  const _Biografia({required this.texto, this.destaque, this.complemento});

  @override
  Widget build(BuildContext context) {
    final estiloBase = GoogleFonts.courierPrime(
      fontSize: 17,
      color: Cores.slate300,
      height: 1.7,
    );

    if (destaque == null) {
      return Text(texto, style: estiloBase);
    }

    return Text.rich(
      TextSpan(
        style: estiloBase,
        children: <InlineSpan>[
          TextSpan(text: texto),
          TextSpan(
            text: destaque,
            style: const TextStyle(
              color: Cores.purple400,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: complemento ?? ''),
        ],
      ),
    );
  }
}
