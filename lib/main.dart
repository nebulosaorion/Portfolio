import 'package:flutter/material.dart';
import 'pagina_portfolio.dart';
import 'tema.dart';

void main() => runApp(const Aplicativo());

class Aplicativo extends StatelessWidget {
  const Aplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfólio | Miriã Evangelista',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Cores.slate950,
        colorScheme: const ColorScheme.dark(
          primary: Cores.purple500,
          surface: Cores.slate950,
        ),
      ),
      home: const PaginaPortfolio(),
    );
  }
}
