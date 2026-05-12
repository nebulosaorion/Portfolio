import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../tema.dart';

class SecaoPrincipal extends StatefulWidget {
  const SecaoPrincipal({super.key});

  @override
  State<SecaoPrincipal> createState() => _EstadoSecaoPrincipal();
}

class _EstadoSecaoPrincipal extends State<SecaoPrincipal>
    with TickerProviderStateMixin {
  late AnimationController _pulso;

  final _avatarKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pulso = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulso.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final altura = MediaQuery.sizeOf(context).height;
    final eMobile = Responsivo.eMobile(context);

    return SizedBox(
      width: double.infinity,
      height: altura,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.6,
                colors: [Cores.purple500.withAlpha(25), Colors.transparent],
              ),
            ),
          ),
          const RepaintBoundary(child: _ParticulasFlutuantes()),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: eMobile ? 24 : 48,
                  vertical: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RepaintBoundary(
                      key: _avatarKey,
                      child: _AvatarAnimado(pulso: _pulso),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Miriã Evangelista',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.windSong(
                        fontSize: eMobile ? 48 : 80,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _TextoMaquinaEscrever(
                      textos: const [
                        'Engenharia de Computação',
                        'Desenvolvedora Full Stack',
                        'Modelagem de Séries Temporais',
                        'Visão Computacional',
                        'Desenvolvimento Web',
                      ],
                      estilo: GoogleFonts.courierPrime(
                        fontSize: eMobile ? 16 : 20,
                        color: Cores.purple300,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        _BotaoSocial(
                          icone: FontAwesomeIcons.github,
                          url: 'https://github.com/nebulosaorion',
                        ),
                        _BotaoSocial(
                          icone: FontAwesomeIcons.linkedin,
                          url: 'https://www.linkedin.com/in/engmi96/',
                        ),
                        _BotaoSocial(
                          icone: FontAwesomeIcons.envelope,
                          url: 'mailto:evangelista@furg.br',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _brilho = [
  Color(0xFFFFFFFF),
  Color(0xFFE2E8F0),
  Color(0xFFCBD5E1),
  Color(0xFFBAE6FD),
  Color(0xFFF0ABFC),
];

class _Particula {
  final double x, y;
  final double tamanho;
  final double opacidade;
  final double fase;
  final double velocidade;
  final Color cor;

  const _Particula({
    required this.x,
    required this.y,
    required this.tamanho,
    required this.opacidade,
    required this.fase,
    required this.velocidade,
    required this.cor,
  });
}

class _ParticulasFlutuantes extends StatefulWidget {
  const _ParticulasFlutuantes();

  @override
  State<_ParticulasFlutuantes> createState() => _EstadoParticulasFlutuantes();
}

class _EstadoParticulasFlutuantes extends State<_ParticulasFlutuantes>
    with SingleTickerProviderStateMixin {
  late AnimationController _controlador;
  late List<_Particula> _particulas;

  @override
  void initState() {
    super.initState();
    _controlador = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // semente fixa para posições consistentes entre recarregamentos
    final aleatorio = Random(42);
    _particulas = List.generate(
      35,
      (_) => _Particula(
        x: aleatorio.nextDouble(),
        y: aleatorio.nextDouble(),
        tamanho: 1.5 + aleatorio.nextDouble() * 3.0,
        opacidade: 0.4 + aleatorio.nextDouble() * 0.5,
        fase: aleatorio.nextDouble() * 2 * pi,
        velocidade: 0.3 + aleatorio.nextDouble() * 0.7,
        cor: _brilho[aleatorio.nextInt(_brilho.length)],
      ),
    );
  }

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controlador,
      builder: (_, _) {
        final tempo = _controlador.value * 2 * pi;
        return LayoutBuilder(
          builder: (_, restricoes) => Stack(
            children: _particulas.map((p) {
              final deslocamentoY = sin(tempo * p.velocidade + p.fase) * 14;
              final transparencia = p.opacidade *
                  (0.55 + 0.45 * sin(tempo * p.velocidade + p.fase + pi / 2));
              return Positioned(
                left: p.x * restricoes.maxWidth,
                top: p.y * restricoes.maxHeight + deslocamentoY,
                child: Opacity(
                  opacity: transparencia.clamp(0.0, 1.0),
                  child: Container(
                    width: p.tamanho,
                    height: p.tamanho,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: p.cor,
                      boxShadow: [
                        BoxShadow(
                          color: p.cor.withAlpha(180),
                          blurRadius: p.tamanho * 2,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _TextoMaquinaEscrever extends StatefulWidget {
  final List<String> textos;
  final TextStyle estilo;

  const _TextoMaquinaEscrever({required this.textos, required this.estilo});

  @override
  State<_TextoMaquinaEscrever> createState() => _EstadoTextoMaquinaEscrever();
}

class _EstadoTextoMaquinaEscrever extends State<_TextoMaquinaEscrever> {
  int _indiceFrase = 0;
  int _indiceChar = 0;
  bool _apagando = false;
  Timer? _temporizador;

  @override
  void initState() {
    super.initState();
    _agendar();
  }

  void _agendar() {
    final frase = widget.textos[_indiceFrase];
    Duration atraso;

    if (!_apagando && _indiceChar < frase.length) {
      atraso = const Duration(milliseconds: 70);
    } else if (!_apagando && _indiceChar == frase.length) {
      atraso = const Duration(milliseconds: 2000);
    } else if (_apagando && _indiceChar > 0) {
      atraso = const Duration(milliseconds: 38);
    } else {
      atraso = const Duration(milliseconds: 400);
    }

    _temporizador = Timer(atraso, () {
      if (!mounted) return;
      setState(() {
        final frase = widget.textos[_indiceFrase];
        if (!_apagando) {
          if (_indiceChar < frase.length) {
            _indiceChar++;
          } else {
            _apagando = true;
          }
        } else {
          if (_indiceChar > 0) {
            _indiceChar--;
          } else {
            _apagando = false;
            _indiceFrase = (_indiceFrase + 1) % widget.textos.length;
          }
        }
      });
      _agendar();
    });
  }

  @override
  void dispose() {
    _temporizador?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final frase = widget.textos[_indiceFrase];
    final visivel = frase.substring(0, _indiceChar.clamp(0, frase.length));
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(visivel, style: widget.estilo),
        _CursorPiscante(estilo: widget.estilo.copyWith(color: Cores.purple400)),
      ],
    );
  }
}

class _CursorPiscante extends StatefulWidget {
  final TextStyle estilo;
  const _CursorPiscante({required this.estilo});

  @override
  State<_CursorPiscante> createState() => _EstadoCursorPiscante();
}

class _EstadoCursorPiscante extends State<_CursorPiscante>
    with SingleTickerProviderStateMixin {
  late AnimationController _piscar;

  @override
  void initState() {
    super.initState();
    _piscar = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _piscar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _piscar,
      child: Text('|', style: widget.estilo),
    );
  }
}

class _AvatarAnimado extends StatelessWidget {
  final AnimationController pulso;
  const _AvatarAnimado({required this.pulso});

  @override
  Widget build(BuildContext context) {
    final tamanho = Responsivo.eMobile(context) ? 180.0 : 210.0;

    return AnimatedBuilder(
      animation: pulso,
      builder: (_, _) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: tamanho + 40,
            height: tamanho + 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Cores.purple500.withAlpha((30 + 40 * pulso.value).round()),
            ),
          ),
          Container(
            width: tamanho,
            height: tamanho,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Cores.purple500.withAlpha(128), width: 4),
              boxShadow: [
                BoxShadow(
                  color: Cores.purple500.withAlpha((60 + 80 * pulso.value).round()),
                  blurRadius: 40,
                  spreadRadius: 4,
                ),
              ],
              image: const DecorationImage(
                image: AssetImage('assets/perfil.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Cores.purple600,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF020617), width: 3),
              ),
              child: const Icon(Icons.code, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _BotaoSocial extends StatefulWidget {
  final IconData icone;
  final String url;
  const _BotaoSocial({required this.icone, required this.url});

  @override
  State<_BotaoSocial> createState() => _EstadoBotaoSocial();
}

class _EstadoBotaoSocial extends State<_BotaoSocial> {
  bool _pairando = false;

  Future<void> _abrir() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (pairando) => setState(() => _pairando = pairando),
      onTap: _abrir,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: _pairando ? Cores.purple600 : Cores.purple600.withAlpha(180),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: FaIcon(widget.icone, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
