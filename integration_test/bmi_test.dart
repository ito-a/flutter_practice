import 'package:flutter/material.dart';
import 'package:flutter_practice/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('group', () {
    testWidgets('start', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final finder = find.widgetWithText(ElevatedButton, '計算する');
      expect(finder, findsOneWidget);

      final finderHeight = find.byKey(const ValueKey('height_text'));
      final finderWeight = find.byKey(const ValueKey('weight_text'));
      await tester.enterText(finderHeight, '160');
      await tester.enterText(finderWeight, '50');

      expect(find.text('160'), findsOneWidget);
      expect(find.text('50'), findsOneWidget);

      await tester.tap(finder);
      await tester.pumpAndSettle();

      expect(find.text('結果発表'), findsOneWidget);
      expect(find.text('19.5'), findsOneWidget);

      final reCalculatorFinder = find.widgetWithText(ElevatedButton, '再計算');
      expect(reCalculatorFinder, findsOneWidget);
    });
  });
}
