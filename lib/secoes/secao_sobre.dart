import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tema.dart';
import 'compartilhado.dart';

class SecaoSobre extends StatelessWidget {
  const SecaoSobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Cores.slate900.withAlpha(128),
      child: const ContainerSecao(
        filho: Column(
          children: [
            TituloSecao(texto: 'Sobre Mim'),
            SizedBox(height: 32),
            CartaoEscuro(
              filho: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Biografia(
                    texto: 'Olá! Meu nome é ',
                    destaque: 'Miriã Evangelista',
                    complemento:
                        ', tenho 30 anos e sou natural de Rio Grande, RS. '
                        'Faço graduação em Engenharia de Computação na Universidade Federal do Rio Grande (FURG), '
                        'onde participo ativamente de projetos de pesquisa e desenvolvimento.',
                  ),
                  SizedBox(height: 16),
                  _Biografia(
                    texto:
                        'Trabalho com modelagem de séries temporais, sempre explorando novas abordagens. '
                        'No tempo livre, gosto de literatura, música e filmes, com preferência por suspense e ficção científica.',
                  ),
                ],
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
