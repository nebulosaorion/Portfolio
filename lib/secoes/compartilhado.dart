import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tema.dart';

class RevelarAoRolar extends StatefulWidget {
  final Widget filho;
  final ScrollController controladorRolagem;
  final Duration atraso;

  const RevelarAoRolar({
    super.key,
    required this.filho,
    required this.controladorRolagem,
    this.atraso = Duration.zero,
  });

  @override
  State<RevelarAoRolar> createState() => _EstadoRevelarAoRolar();
}

class _EstadoRevelarAoRolar extends State<RevelarAoRolar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controlador;
  late Animation<double> _opacidade;
  late Animation<Offset> _deslize;
  bool _revelado = false;

  @override
  void initState() {
    super.initState();
    _controlador = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _opacidade = CurvedAnimation(parent: _controlador, curve: Curves.easeOut);
    _deslize = Tween<Offset>(
      begin: const Offset(0, 0.07),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controlador, curve: Curves.easeOut));

    widget.controladorRolagem.addListener(_verificar);
    WidgetsBinding.instance.addPostFrameCallback((_) => _verificar());
  }

  void _verificar() {
    if (_revelado || !mounted) return;
    final caixa = context.findRenderObject() as RenderBox?;
    if (caixa == null) return;
    final alturaTela = MediaQuery.sizeOf(context).height;
    if (caixa.localToGlobal(Offset.zero).dy < alturaTela * 0.92) {
      _revelado = true;
      Future.delayed(widget.atraso, () {
        if (mounted) _controlador.forward();
      });
    }
  }

  @override
  void dispose() {
    widget.controladorRolagem.removeListener(_verificar);
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacidade,
      child: SlideTransition(position: _deslize, child: widget.filho),
    );
  }
}

class ContainerSecao extends StatelessWidget {
  final Widget filho;
  const ContainerSecao({super.key, required this.filho});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
          child: filho,
        ),
      ),
    );
  }
}

class TituloSecao extends StatelessWidget {
  final String texto;
  const TituloSecao({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: TextAlign.center,
      style: GoogleFonts.playwriteNo(
        fontSize: 42,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }
}

class CartaoEscuro extends StatefulWidget {
  final Widget filho;
  final bool comHover;
  final VoidCallback? aoTocar;

  const CartaoEscuro({
    super.key,
    required this.filho,
    this.comHover = false,
    this.aoTocar,
  });

  @override
  State<CartaoEscuro> createState() => _EstadoCartaoEscuro();
}

class _EstadoCartaoEscuro extends State<CartaoEscuro> {
  bool _pairando = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (pairando) {
        if (widget.comHover) setState(() => _pairando = pairando);
      },
      onTap: widget.aoTocar,
      child: AnimatedScale(
        scale: _pairando && widget.comHover ? 1.03 : 1.0,
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
          child: widget.filho,
        ),
      ),
    );
  }
}

class ChipHabilidade extends StatelessWidget {
  final String rotulo;
  final bool pequeno;
  const ChipHabilidade({super.key, required this.rotulo, this.pequeno = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: pequeno ? 8 : 12,
        vertical: pequeno ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: pequeno
            ? Cores.slate800.withAlpha(180)
            : Cores.purple600.withAlpha(77),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        rotulo,
        style: TextStyle(fontSize: pequeno ? 11 : 13, color: Cores.purple200),
      ),
    );
  }
}
