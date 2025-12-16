import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bookly/main.dart';

void main() {
  testWidgets('BooklyApp widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const BooklyApp());

    expect(find.text('Bookly'), findsOneWidget);
    expect(find.text('Читай. Изучай. Вдохновляйся.'), findsOneWidget);
  });
}