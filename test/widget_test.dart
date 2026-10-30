import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cat_tech/main.dart';

void main() {
  testWidgets('La aplicación inicia correctamente', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CatTechApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
