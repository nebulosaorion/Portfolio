import 'package:flutter/material.dart';

import 'habilidade.dart';

class CategoriaHabilidade {
  final String rotulo;
  final IconData icone;
  final List<Habilidade> habilidades;

  const CategoriaHabilidade(this.rotulo, this.icone, this.habilidades);
}
