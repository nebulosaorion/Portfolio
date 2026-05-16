import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dados/projetos_pesquisa.dart';
import '../tema.dart';
import 'compartilhado.dart';

class SecaoPesquisa extends StatelessWidget {
  const SecaoPesquisa({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Cores.slate900.withAlpha(128),
      child: ContainerSecao(
        filho: Column(
          children: [
            const TituloSecao(texto: 'Projetos de Pesquisa'),
            const SizedBox(height: 48),
            ...(projetosPesquisa.map(
              (projeto) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CartaoEscuro(
                  filho: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              projeto.titulo,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Cores.purple300,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Cores.purple600.withAlpha(51),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              projeto.periodo,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Cores.purple400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        projeto.descricao,
                        style: GoogleFonts.courierPrime(
                          fontSize: 15,
                          color: Cores.slate300,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
