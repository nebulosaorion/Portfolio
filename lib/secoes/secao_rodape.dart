import 'package:flutter/material.dart';
import '../tema.dart';

class SecaoRodape extends StatelessWidget {
  const SecaoRodape({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      decoration: BoxDecoration(
        color: Cores.slate900.withAlpha(204),
        border: Border(top: BorderSide(color: Cores.purple500.withAlpha(51))),
      ),
      child: const Text(
        '© 2026 Miriã Evangelista. Desenvolvido com Flutter.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Cores.slate400, fontSize: 14),
      ),
    );
  }
}
