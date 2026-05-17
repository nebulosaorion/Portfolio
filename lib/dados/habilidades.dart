import 'package:flutter/material.dart';

import '../modelos/categoria_habilidade.dart';
import '../modelos/habilidade.dart';

const categoriasHabilidade = [
  CategoriaHabilidade('Linguagens', Icons.code, [
    Habilidade('Python'),
    Habilidade('Dart'),
    Habilidade('C'),
    Habilidade('Go'),
    Habilidade('JavaScript'),
    Habilidade('HTML5'),
    Habilidade('CSS3'),
  ]),
  CategoriaHabilidade('Frameworks & Ferramentas', Icons.terminal, [
    Habilidade('FastAPI'),
    Habilidade('Flutter'),
    Habilidade('ROS2'),
    Habilidade('Docker'),
    Habilidade('MongoDB'),
    Habilidade('Git'),
    Habilidade('GitHub'),
    Habilidade('Linux'),
    Habilidade('Canva'),
    Habilidade('Figma'),
  ]),
];
