import 'package:flutter_test/flutter_test.dart';
import 'package:nextech/main.dart';

void main() {
  testWidgets('La aplicación NexTech inicia correctamente', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NexTechApp());

    expect(find.text('NexTech'), findsOneWidget);
    expect(find.text('Bienvenido a NexTech'), findsOneWidget);
  });
}
