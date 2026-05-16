import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  static const _iconeReserva = Icon(
    Icons.code,
    color: Cores.purple400,
    size: 36,
  );

  @override
  Widget build(BuildContext context) {
    if (habilidade.url == null) return _iconeReserva;

    return SvgPicture.network(
      habilidade.url!,
      width: 40,
      height: 40,
      colorFilter: habilidade.filtrosBranco
          ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
          : null,
      placeholderBuilder: (_) => const SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              color: Cores.purple400,
            ),
          ),
        ),
      ),
      errorBuilder: (_, erro, stackTrace) => _iconeReserva,
    );
  }
}
