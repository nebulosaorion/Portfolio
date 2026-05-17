class Habilidade {
  final String nome;
  final String? svgPath;
  final bool filtrosBranco;

  const Habilidade(
    this.nome, {
    this.svgPath,
    this.filtrosBranco = false,
  });
}
