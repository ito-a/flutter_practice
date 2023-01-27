import 'package:flutter/material.dart';
import 'package:flutter_practice/bmi/app.dart';
import 'package:flutter_practice/bmi/top.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('BMI Top Widget Tests', () {
    testWidgets('Topページの初期表示項目を調べる', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      expect(find.text('MALE'), findsOneWidget);
      expect(find.text('FEMALE'), findsOneWidget);
      expect(find.text('身長 (cm)'), findsOneWidget);
      expect(find.text('体重 (kg)'), findsOneWidget);
      expect(find.text('計算する'), findsOneWidget);

      final genderMaleButton = find.byKey(const ValueKey("gender_male_button"));
      expect(genderMaleButton, findsOneWidget);

      final genderFemaleButton = find.byKey(const ValueKey("gender_female_button"));
      expect(genderFemaleButton, findsOneWidget);

      final heightTextField = find.byKey(const ValueKey("height_text"));
      expect(heightTextField, findsOneWidget);

      final weightTextField = find.byKey(const ValueKey("weight_text"));
      expect(weightTextField, findsOneWidget);

      final calculatorButton = find.byKey(const ValueKey("calculator_button"));
      expect(calculatorButton, findsOneWidget);
    });

    testWidgets('テキスト入力をする', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      final finderHeight = find.byKey(const ValueKey('height_text'));
      final finderWeight = find.byKey(const ValueKey('weight_text'));
      await tester.enterText(finderHeight, '160');
      await tester.enterText(finderWeight, '50');

      expect(find.text('160'), findsOneWidget);
      expect(find.text('50'), findsOneWidget);
    });

    testWidgets('性別ボタンの色を確認する', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      final finder = find.widgetWithText(ElevatedButton, 'FEMALE');
      final widget = tester.firstWidget(finder) as ElevatedButton;
      final states = <MaterialState>{};
      final bgColor = widget.style?.backgroundColor?.resolve(states);

      expect(bgColor, Colors.grey);

      await tester.tap(finder);
      await tester.pump();
    });

    testWidgets('リフレッシュボタンをタップすると身長と体重の入力値が０になる', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      final finder = find.widgetWithIcon(FloatingActionButton, Icons.refresh);
      expect(finder, findsOneWidget);

      await tester.tap(finder);

      expect(find.text('0'), findsNWidgets(2));
    });
  });
}
