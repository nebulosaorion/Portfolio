import 'package:flutter/material.dart';

import '../modelos/categoria_habilidade.dart';
import '../modelos/habilidade.dart';

const categoriasHabilidade = [
  CategoriaHabilidade('Linguagens', Icons.code, [
    Habilidade('Python', svgPath: 'assets/skills/python-original.svg'),
    Habilidade('Dart', svgPath: 'assets/skills/dart-original-wordmark.svg'),
    Habilidade('C', svgPath: 'assets/skills/c-original.svg'),
    Habilidade('Go', svgPath: 'assets/skills/go-original.svg'),
    Habilidade(
      'JavaScript',
      svgPath: 'assets/skills/javascript-original.svg',
    ),
    Habilidade('HTML5', svgPath: 'assets/skills/html5-original.svg'),
    Habilidade('CSS3', svgPath: 'assets/skills/css3-original.svg'),
  ]),
  CategoriaHabilidade('Frameworks & Ferramentas', Icons.terminal, [
    Habilidade('FastAPI', svgPath: 'assets/skills/fastapi-original.svg'),
    Habilidade('Flutter'),
    Habilidade('ROS2', svgPath: 'assets/skills/ros-original-wordmark.svg'),
    Habilidade('Docker', svgPath: 'assets/skills/docker-original.svg'),
    Habilidade('MongoDB', svgPath: 'assets/skills/mongodb-original.svg'),
    Habilidade('Git', svgPath: 'assets/skills/git-original.svg'),
    Habilidade(
      'GitHub',
      svgPath: 'assets/skills/github-original.svg',
      filtrosBranco: true,
    ),
    Habilidade('Linux', svgPath: 'assets/skills/linux-original.svg'),
    Habilidade('Canva', svgPath: 'assets/skills/canva-original.svg'),
    Habilidade('Figma', svgPath: 'assets/skills/figma-original.svg'),
  ]),
];
