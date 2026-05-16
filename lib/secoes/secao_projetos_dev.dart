import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dados/projetos_dev.dart';
import '../modelos/projeto_dev.dart';
import '../tema.dart';
import '../util/abridor_link.dart';
import 'compartilhado.dart';

class SecaoProjetosDev extends StatelessWidget {
  const SecaoProjetosDev({super.key});

  @override
  Widget build(BuildContext context) {
    final eMobile = Responsivo.eTablet(context);

    return ContainerSecao(
      filho: Column(
        children: [
          const TituloSecao(texto: 'Projetos de Desenvolvimento'),
          const SizedBox(height: 48),
          eMobile
              ? Column(
                  children: projetosDev
                      .map(
                        (p) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _CartaoProjeto(projeto: p),
                        ),
                      )
                      .toList(),
                )
              : _GradeDuasColunas(
                  filhos: projetosDev
                      .map((p) => _CartaoProjeto(projeto: p))
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _GradeDuasColunas extends StatelessWidget {
  final List<Widget> filhos;
  const _GradeDuasColunas({required this.filhos});

  @override
  Widget build(BuildContext context) {
    final linhas = <Widget>[];
    for (var i = 0; i < filhos.length; i += 2) {
      linhas.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: filhos[i]),
              const SizedBox(width: 16),
              Expanded(
                child: i + 1 < filhos.length ? filhos[i + 1] : const SizedBox(),
              ),
            ],
          ),
        ),
      );
    }
    return Column(children: linhas);
  }
}

class _CartaoProjeto extends StatefulWidget {
  final ProjetoDev projeto;

  const _CartaoProjeto({required this.projeto});

  @override
  State<_CartaoProjeto> createState() => _EstadoCartaoProjeto();
}

class _EstadoCartaoProjeto extends State<_CartaoProjeto> {
  bool _pairando = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (pairando) => setState(() => _pairando = pairando),
      onTap: () => abrirLink(widget.projeto.url),
      child: AnimatedScale(
        scale: _pairando ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Cores.slate800.withAlpha(128),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _pairando
                  ? Cores.purple500.withAlpha(102)
                  : Cores.purple500.withAlpha(51),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.projeto.titulo,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Cores.purple300,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _pairando ? 1 : 0.4,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.open_in_new,
                      color: Cores.purple400,
                      size: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.projeto.descricao,
                style: GoogleFonts.courierPrime(
                  fontSize: 14,
                  color: Cores.slate300,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: widget.projeto.tecnologias
                    .map((t) => ChipHabilidade(rotulo: t, pequeno: true))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
