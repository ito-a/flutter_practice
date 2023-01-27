import 'package:flutter_practice/bmi/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final genderProvider = StateProvider((ref) => Gender.male);

void main() {
  late BmiCalculatorController target;

  setUp(() {
    final container = ProviderContainer();
    target = container.read(bmiCalculatorProvider.notifier);
  });

  test("BMI算出のテスト", () {
    expect(target.debugState, "");
    final bmi = target.getResult(160, 50);
    expect(bmi, "19.5");

    // target.input("5");
    // expect(target.debugState, "5");
  });
}
