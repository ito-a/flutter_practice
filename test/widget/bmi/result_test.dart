import 'package:flutter/material.dart';
import 'package:flutter_practice/bmi/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Display of Result screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(
      child: MaterialApp(
        home: Result(),
      ),
    ));

    expect(find.text('結果発表'), findsOneWidget);

    final reCalculatorFinder = find.widgetWithText(ElevatedButton, '再計算');
    expect(reCalculatorFinder, findsOneWidget);
  });
}
