import 'package:flutter/material.dart';

import '../modelos/categoria_habilidade.dart';
import '../modelos/habilidade.dart';

const cdnDevicons =
    'https://cdn.jsdelivr.net/gh/devicons/devicon@v2.16.0/icons/';

const categoriasHabilidade = [
  CategoriaHabilidade('Linguagens', Icons.code, [
    Habilidade('Python', url: '${cdnDevicons}python/python-original.svg'),
    Habilidade('Dart', url: '${cdnDevicons}dart/dart-original-wordmark.svg'),
    Habilidade('C', url: '${cdnDevicons}c/c-original.svg'),
    Habilidade('Go', url: '${cdnDevicons}go/go-original.svg'),
    Habilidade(
      'JavaScript',
      url: '${cdnDevicons}javascript/javascript-original.svg',
    ),
    Habilidade('HTML5', url: '${cdnDevicons}html5/html5-original.svg'),
    Habilidade('CSS3', url: '${cdnDevicons}css3/css3-plain-wordmark.svg'),
  ]),
  CategoriaHabilidade('Frameworks & Ferramentas', Icons.terminal, [
    Habilidade(
      'FastAPI',
      url: '${cdnDevicons}fastapi/fastapi-plain-wordmark.svg',
    ),
    Habilidade('Flutter', url: '${cdnDevicons}flutter/flutter-plain.svg'),
    Habilidade('ROS2', url: '${cdnDevicons}ros/ros-original-wordmark.svg'),
    Habilidade(
      'Docker',
      url: '${cdnDevicons}docker/docker-original-wordmark.svg',
    ),
    Habilidade(
      'MongoDB',
      url: '${cdnDevicons}mongodb/mongodb-original-wordmark.svg',
    ),
    Habilidade('Git', url: '${cdnDevicons}git/git-original-wordmark.svg'),
    Habilidade(
      'GitHub',
      url: '${cdnDevicons}github/github-original.svg',
      filtrosBranco: true,
    ),
    Habilidade('Linux', url: '${cdnDevicons}linux/linux-original.svg'),
    Habilidade('Canva', url: '${cdnDevicons}canva/canva-original.svg'),
    Habilidade('Figma', url: '${cdnDevicons}figma/figma-original.svg'),
  ]),
];
