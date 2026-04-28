# Portfólio — Miriã Evangelista

Portfólio pessoal desenvolvido em Flutter Web, apresentando minha trajetória acadêmica, projetos de pesquisa, projetos de desenvolvimento e habilidades técnicas.

## Tecnologias

- **Flutter** — framework principal
- **Google Fonts** — fontes WindSong, Playwrite NO e Courier Prime
- **Font Awesome Flutter** — ícones de redes sociais
- **url_launcher** — abertura de links externos
- **Devicons CDN** — logos das tecnologias na seção de habilidades

## Seções

| Seção | Descrição |
|---|---|
| Hero | Foto, nome, efeito máquina de escrever e redes sociais |
| Sobre Mim | Apresentação pessoal |
| Projetos de Pesquisa |
| Projetos de Desenvolvimento | Repositórios no GitHub |
| Habilidades Técnicas | Linguagens, frameworks e ferramentas |

## Como rodar

```bash
flutter pub get
flutter run -d chrome --web-port 8080
```

Para gerar o build de produção:

```bash
flutter build web --release
```

## Estrutura

```
lib/
├── main.dart
├── tema.dart
├── pagina_portfolio.dart
├── tema/
│   ├── cores.dart
│   └── responsivo.dart
└── secoes/
    ├── compartilhado.dart
    ├── secao_principal.dart
    ├── secao_sobre.dart
    ├── secao_pesquisa.dart
    ├── secao_projetos_dev.dart
    ├── secao_habilidades.dart
    └── secao_rodape.dart
```
