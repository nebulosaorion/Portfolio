import 'package:flutter/material.dart';
import '../dados/habilidades.dart';
import '../modelos/categoria_habilidade.dart';
import '../modelos/habilidade.dart';
import '../tema.dart';
import 'compartilhado.dart';

class SecaoHabilidades extends StatelessWidget {
  const SecaoHabilidades({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerSecao(
      filho: Column(
        children: [
          const TituloSecao(texto: 'Habilidades Técnicas'),
          const SizedBox(height: 48),
          ...categoriasHabilidade.map((c) => _BlocoCategoria(categoria: c)),
        ],
      ),
    );
  }
}

class _BlocoCategoria extends StatelessWidget {
  final CategoriaHabilidade categoria;
  const _BlocoCategoria({required this.categoria});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(categoria.icone, color: Cores.purple400, size: 20),
              const SizedBox(width: 10),
              Text(
                categoria.rotulo,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: categoria.habilidades
                .map((h) => _CartaoHabilidade(habilidade: h))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _CartaoHabilidade extends StatefulWidget {
  final Habilidade habilidade;
  const _CartaoHabilidade({required this.habilidade});

  @override
  State<_CartaoHabilidade> createState() => _EstadoCartaoHabilidade();
}

class _EstadoCartaoHabilidade extends State<_CartaoHabilidade> {
  bool _pairando = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _pairando = true),
      onExit: (_) => setState(() => _pairando = false),
      child: AnimatedScale(
        scale: _pairando ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 88,
          height: 96,
          decoration: BoxDecoration(
            color: _pairando
                ? const Color(0xFF334155)
                : const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _pairando
                  ? Cores.purple400.withAlpha(220)
                  : Cores.purple500.withAlpha(100),
              width: 1.5,
            ),
            boxShadow: _pairando
                ? [
                    BoxShadow(
                      color: Cores.purple500.withAlpha(90),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LogoHabilidade(habilidade: widget.habilidade),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  widget.habilidade.nome,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: _pairando ? Colors.white : Cores.slate300,
                    fontWeight: _pairando ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoHabilidade extends StatelessWidget {
  final Habilidade habilidade;
  const _LogoHabilidade({required this.habilidade});

  static const _coresLogo = [
    Color(0xFF38BDF8),
    Color(0xFF22C55E),
    Color(0xFFF59E0B),
    Color(0xFFF43F5E),
    Color(0xFFA78BFA),
    Color(0xFF14B8A6),
  ];

  static const _icones = {
    'Python': Icons.data_object,
    'Dart': Icons.flutter_dash,
    'C': Icons.memory,
    'Go': Icons.bolt,
    'JavaScript': Icons.javascript,
    'HTML5': Icons.language,
    'CSS3': Icons.brush,
    'FastAPI': Icons.api,
    'Flutter': Icons.phone_iphone,
    'ROS2': Icons.precision_manufacturing,
    'Docker': Icons.inventory_2,
    'MongoDB': Icons.storage,
    'Git': Icons.account_tree,
    'GitHub': Icons.code,
    'Linux': Icons.terminal,
    'Canva': Icons.palette,
    'Figma': Icons.design_services,
  };

  int _indiceCor(String nome) {
    var soma = 0;
    for (final codigo in nome.codeUnits) {
      soma += codigo;
    }
    return soma % _coresLogo.length;
  }

  String _rotulo(String nome) {
    final partes = nome
        .split(RegExp(r'\s+'))
        .where((parte) => parte.isNotEmpty)
        .toList();

    if (partes.length >= 2) {
      return '${partes.first[0]}${partes.last[0]}'.toUpperCase();
    }

    final normalizado = nome.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');
    if (normalizado.isEmpty) return '?';
    return normalizado.substring(0, normalizado.length >= 2 ? 2 : 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final cor = _coresLogo[_indiceCor(habilidade.nome)];
    final icone = _icones[habilidade.nome];

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cor.withAlpha(230), cor.withAlpha(150)],
        ),
        border: Border.all(color: Colors.white.withAlpha(35)),
      ),
      child: Center(
        child: icone != null
            ? Icon(icone, color: Colors.white, size: 24)
            : Text(
                _rotulo(habilidade.nome),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
      ),
    );
  }
}
