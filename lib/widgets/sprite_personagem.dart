import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum _Fase { aguardando, entrando, empurrando, apoiando }

// Rects de origem na spritesheet reempacotada.
// Mapeamento usado:
// - linha 0: caminhada
// - linha 2: empurrando
// - linha 3: repouso/ofegante
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

const Rect _frameIdle = Rect.fromLTWH(967, 544, 81, 128);

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

  // Posição do sprite (borda esquerda)
  double _x = 0;
  double _y = 0;

  // Âncora da borda direita (fixa após entrar)
  double _bordaDireita = 0;
  double _alturaDisplay = 0;

  int _frameIdx = 0;
  late AnimationController _movimento;
  late Animation<double> _xAnim;
  Timer? _frameTimer;

  @override
  void initState() {
    super.initState();
    _movimento = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
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

    // Posição do avatar relativa ao Stack da SecaoPrincipal
    final avatarPos = stackBox.globalToLocal(avatarBox.localToGlobal(Offset.zero));
    final avatarSize = avatarBox.size;

    // O avatar Stack é (tamanho+40)×(tamanho+40). O círculo da foto fica 20px dentro.
    final photoLeft = avatarPos.dx + 20;
    final photoBottom = avatarPos.dy + avatarSize.height - 20;

    // Altura de display: 55% do Stack do avatar
    _alturaDisplay = avatarSize.height * 0.55;

    // Largura do frame de andar para calcular a âncora
    final srcWalk0 = _framesAndar[0];
    final larguraAndar = srcWalk0.width * _alturaDisplay / srcWalk0.height;

    // Borda direita fica 25px dentro da borda esquerda da foto (efeito de encostar)
    _bordaDireita = photoLeft + 25;

    final targetX = _bordaDireita - larguraAndar;
    final startX = -(larguraAndar + 20);

    _xAnim = Tween<double>(begin: startX, end: targetX).animate(
      CurvedAnimation(parent: _movimento, curve: Curves.easeInOut),
    );
    _xAnim.addListener(() {
      if (mounted) setState(() => _x = _xAnim.value);
    });

    setState(() {
      _x = startX;
      _y = photoBottom - _alturaDisplay;
      _fase = _Fase.entrando;
      _frameIdx = 0;
    });

    // Ritmo mais lento para a caminhada parecer leve e deliberada.
    _frameTimer = Timer.periodic(const Duration(milliseconds: 150), _tickFrame);
    _movimento.forward().then((_) {
      if (mounted) _iniciarEmpurrar();
    });
  }

  void _tickFrame(Timer _) {
    if (!mounted) return;
    setState(() {
      switch (_fase) {
        case _Fase.entrando:
          _frameIdx = (_frameIdx + 1) % _framesAndar.length;
        case _Fase.empurrando:
          if (_frameIdx < _framesEmpurrar.length - 1) _frameIdx++;
        default:
          break;
      }
    });
  }

  void _iniciarEmpurrar() {
    if (!mounted) return;
    setState(() {
      _fase = _Fase.empurrando;
      _frameIdx = 0;
    });
    widget.onEmpurrar();
    // Após a animação de empurrar, vai para apoiando
    Timer(const Duration(milliseconds: 1100), () {
      if (!mounted) return;
      _frameTimer?.cancel();
      setState(() {
        _fase = _Fase.apoiando;
      });
    });
  }

  @override
  void dispose() {
    _movimento.dispose();
    _frameTimer?.cancel();
    super.dispose();
  }

  Rect get _srcAtual => switch (_fase) {
        _Fase.entrando =>
          _framesAndar[_frameIdx.clamp(0, _framesAndar.length - 1)],
        _Fase.empurrando =>
          _framesEmpurrar[_frameIdx.clamp(0, _framesEmpurrar.length - 1)],
        _ => _frameIdle,
      };

  @override
  Widget build(BuildContext context) {
    // Sempre ocupa o Stack inteiro (IgnorePointer não bloqueia interações).
    // O CustomPainter desenha nas coordenadas absolutas do Stack,
    // evitando problemas com Positioned dentro de StatefulWidget filho de Stack.
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
    final dw = src.width * _alturaDisplay / src.height;
    final left = _fase == _Fase.entrando ? _x : _bordaDireita - dw;
    return _SpritePainter(
      imagem: _imagem!,
      src: src,
      dst: Rect.fromLTWH(left, _y, dw, _alturaDisplay),
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
      Paint()..filterQuality = FilterQuality.none,
    );
  }

  @override
  bool shouldRepaint(_SpritePainter old) => old.src != src || old.dst != dst;
}
