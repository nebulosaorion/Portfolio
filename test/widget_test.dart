import 'package:flutter_test/flutter_test.dart';
import 'package:meuportfolio/main.dart';

void main() {
  testWidgets('Teste de fumaça do aplicativo', (tester) async {
    await tester.pumpWidget(const Aplicativo());
    expect(find.byType(Aplicativo), findsOneWidget);
  });
}
