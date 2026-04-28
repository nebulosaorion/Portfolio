import 'package:flutter/material.dart';
import 'tema.dart';
import 'secoes/compartilhado.dart';
import 'secoes/secao_principal.dart';
import 'secoes/secao_sobre.dart';
import 'secoes/secao_pesquisa.dart';
import 'secoes/secao_projetos_dev.dart';
import 'secoes/secao_habilidades.dart';
import 'secoes/secao_rodape.dart';

class PaginaPortfolio extends StatefulWidget {
  const PaginaPortfolio({super.key});

  @override
  State<PaginaPortfolio> createState() => _EstadoPaginaPortfolio();
}

class _EstadoPaginaPortfolio extends State<PaginaPortfolio> {
  final _rolagem = ScrollController();

  @override
  void dispose() {
    _rolagem.dispose();
    super.dispose();
  }

  Widget _revelar(Widget filho, {Duration atraso = Duration.zero}) =>
      RevelarAoRolar(
        controladorRolagem: _rolagem,
        atraso: atraso,
        filho: filho,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.slate950,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Cores.slate950, Cores.purple950, Cores.slate950],
          ),
        ),
        child: SingleChildScrollView(
          controller: _rolagem,
          child: Column(
            children: [
              const SecaoPrincipal(),
              _revelar(const SecaoSobre()),
              _revelar(const SecaoPesquisa()),
              _revelar(const SecaoProjetosDev()),
              _revelar(const SecaoHabilidades()),
              _revelar(const SecaoRodape()),
            ],
          ),
        ),
      ),
    );
  }
}
