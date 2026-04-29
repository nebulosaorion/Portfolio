import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum _Fase { aguardando, entrando, empurrando, agachando, apoiando }

// linha 0: caminhada
const List<Rect> _framesAndar = [
  Rect.fromLTWH(63, 70, 97, 154),
  Rect.fromLTWH(295, 68, 82, 156),
  Rect.fromLTWH(514, 68, 92, 156),
  Rect.fromLTWH(742, 66, 83, 158),
  Rect.fromLTWH(961, 66, 94, 158),
  Rect.fromLTWH(1189, 68, 86, 156),
  Rect.fromLTWH(1411, 71, 90, 153),
  Rect.fromLTWH(1638, 66, 83, 158),
];

// linha 1: empurrando
const List<Rect> _framesEmpurrar = [
  Rect.fromLTWH(44, 318, 136, 130),
  Rect.fromLTWH(270, 318, 132, 130),
  Rect.fromLTWH(493, 316, 134, 132),
  Rect.fromLTWH(721, 316, 126, 132),
  Rect.fromLTWH(942, 317, 131, 131),
  Rect.fromLTWH(1168, 318, 127, 130),
  Rect.fromLTWH(1392, 317, 128, 131),
  Rect.fromLTWH(1617, 317, 126, 131),
];

// linha 2: agachando
const List<Rect> _framesAgachar = [
  Rect.fromLTWH(75, 557, 73, 115),
  Rect.fromLTWH(294, 545, 84, 127),
  Rect.fromLTWH(518, 552, 84, 120),
  Rect.fromLTWH(743, 561, 81, 111),
  Rect.fromLTWH(967, 544, 81, 128),
  Rect.fromLTWH(1191, 545, 82, 127),
  Rect.fromLTWH(1413, 556, 85, 116),
  Rect.fromLTWH(1639, 560, 81, 112),
];

// linha 3: repouso (loop)
const List<Rect> _framesApoio = [
  Rect.fromLTWH(73, 786, 77, 110),
  Rect.fromLTWH(295, 777, 82, 118),
  Rect.fromLTWH(517, 781, 86, 115),
  Rect.fromLTWH(744, 784, 79, 111),
  Rect.fromLTWH(966, 775, 83, 121),
  Rect.fromLTWH(1190, 776, 83, 120),
  Rect.fromLTWH(1413, 782, 86, 114),
  Rect.fromLTWH(1640, 784, 80, 112),
];

class SpritePersonagem extends StatefulWidget {
  final GlobalKey avatarKey;
  final GlobalKey stackKey;
  final VoidCallback onEmpurrar;

  const SpritePersonagem({
    super.key,
    required this.avatarKey,
    required this.stackKey,
    required this.onEmpurrar,
  });

  @override
  State<SpritePersonagem> createState() => _EstadoSpritePersonagem();
}

class _EstadoSpritePersonagem extends State<SpritePersonagem>
    with SingleTickerProviderStateMixin {
  ui.Image? _imagem;
  _Fase _fase = _Fase.aguardando;

  double _x = 0;
  double _y = 0;
  double _bordaDireita = 0;
  double _alturaDisplay = 0;

  int _frameIdx = 0;
  late AnimationController _movimento;
  late Animation<double> _xAnim;
  Timer? _frameTimer;

  static const _msEmpurrar = 200;
  static const _msAgachar = 260;
  static const _msApoio = 380;

  @override
  void initState() {
    super.initState();
    _movimento = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 9000),
    );
    _carregarImagem();
  }

  Future<void> _carregarImagem() async {
    final data = await rootBundle.load('assets/sprites.png');
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    if (!mounted) return;
    setState(() => _imagem = frame.image);
    WidgetsBinding.instance.addPostFrameCallback(_iniciarAnimacao);
  }

  void _iniciarAnimacao(_) {
    final avatarCtx = widget.avatarKey.currentContext;
    final stackCtx = widget.stackKey.currentContext;
    if (avatarCtx == null || stackCtx == null) return;

    final stackBox = stackCtx.findRenderObject() as RenderBox;
    final avatarBox = avatarCtx.findRenderObject() as RenderBox;

    final avatarPos = stackBox.globalToLocal(avatarBox.localToGlobal(Offset.zero));
    final avatarSize = avatarBox.size;

    final photoLeft = avatarPos.dx + 20;
    final photoBottom = avatarPos.dy + avatarSize.height - 20;

    _alturaDisplay = avatarSize.height * 0.55;

    final srcWalk0 = _framesAndar[0];
    final larguraAndar = srcWalk0.width * _alturaDisplay / srcWalk0.height;

    _bordaDireita = photoLeft + 25;

    final targetX = _bordaDireita - larguraAndar;
    final startX = -(larguraAndar + 20);

    _xAnim = Tween<double>(begin: startX, end: targetX).animate(
      CurvedAnimation(parent: _movimento, curve: Curves.easeInOut),
    );

    // Frames da caminhada dirigidos pela posição (não por tempo),
    // para que os pés sempre sincronizem com a velocidade real do movimento.
    const ciclosAndar = 4;
    _xAnim.addListener(() {
      if (!mounted) return;
      setState(() {
        _x = _xAnim.value;
        if (_fase == _Fase.entrando) {
          _frameIdx = (_movimento.value * ciclosAndar * _framesAndar.length)
                  .toInt() %
              _framesAndar.length;
        }
      });
    });

    setState(() {
      _x = startX;
      _y = photoBottom - _alturaDisplay;
      _fase = _Fase.entrando;
      _frameIdx = 0;
    });

    _movimento.forward().then((_) {
      if (mounted) _iniciarEmpurrar();
    });
  }

  int get _intervaloAtual => switch (_fase) {
        _Fase.empurrando => _msEmpurrar,
        _Fase.agachando => _msAgachar,
        _Fase.apoiando => _msApoio,
        _ => _msEmpurrar,
      };

  void _agendarFrame() {
    _frameTimer = Timer(Duration(milliseconds: _intervaloAtual), () {
      if (!mounted) return;
      setState(() {
        switch (_fase) {
          case _Fase.empurrando:
            if (_frameIdx < _framesEmpurrar.length - 1) {
              _frameIdx++;
            } else {
              _fase = _Fase.agachando;
              _frameIdx = 0;
            }
          case _Fase.agachando:
            if (_frameIdx < _framesAgachar.length - 1) {
              _frameIdx++;
            } else {
              _fase = _Fase.apoiando;
              _frameIdx = 0;
            }
          case _Fase.apoiando:
            _frameIdx = (_frameIdx + 1) % _framesApoio.length;
          default:
            break;
        }
      });
      _agendarFrame();
    });
  }

  void _iniciarEmpurrar() {
    if (!mounted) return;
    setState(() {
      _fase = _Fase.empurrando;
      _frameIdx = 0;
    });
    widget.onEmpurrar();
    _agendarFrame();
  }

  @override
  void dispose() {
    _movimento.dispose();
    _frameTimer?.cancel();
    super.dispose();
  }

  Rect get _srcAtual => switch (_fase) {
        _Fase.entrando => _framesAndar[_frameIdx.clamp(0, _framesAndar.length - 1)],
        _Fase.empurrando => _framesEmpurrar[_frameIdx.clamp(0, _framesEmpurrar.length - 1)],
        _Fase.agachando => _framesAgachar[_frameIdx.clamp(0, _framesAgachar.length - 1)],
        _Fase.apoiando => _framesApoio[_frameIdx.clamp(0, _framesApoio.length - 1)],
        _ => _framesApoio[0],
      };

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox.expand(
        child: _imagem == null || _fase == _Fase.aguardando
            ? null
            : CustomPaint(painter: _buildPainter()),
      ),
    );
  }

  _SpritePainter _buildPainter() {
    final src = _srcAtual;
    // Escala a altura proporcionalmente ao frame de referência (caminhada),
    // mantendo o pé do personagem ancorado ao chão em todas as fases.
    final refH = _framesAndar[0].height;
    final alturaAtual = _alturaDisplay * (src.height / refH);
    final dw = src.width * alturaAtual / src.height;
    final bottom = _y + _alturaDisplay;
    final top = bottom - alturaAtual;
    final left = _fase == _Fase.entrando ? _x : _bordaDireita - dw;
    return _SpritePainter(
      imagem: _imagem!,
      src: src,
      dst: Rect.fromLTWH(left, top, dw, alturaAtual),
    );
  }
}

class _SpritePainter extends CustomPainter {
  final ui.Image imagem;
  final Rect src;
  final Rect dst;

  const _SpritePainter({
    required this.imagem,
    required this.src,
    required this.dst,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImageRect(
      imagem,
      src,
      dst,
      Paint()..filterQuality = FilterQuality.medium,
    );
  }

  @override
  bool shouldRepaint(_SpritePainter old) => old.src != src || old.dst != dst;
}
