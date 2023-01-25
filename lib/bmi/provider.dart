import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genderProvider = StateProvider((ref) => Gender.male);

enum Gender {
  male,
  female,
}

final heightProvider = StateProvider((ref) => '0');

final weightProvider = StateProvider((ref) => '0');

final bmiCalculatorProvider =
    StateNotifierProvider<BmiCalculator, String>((ref) => BmiCalculator());

class BmiCalculator extends StateNotifier<String> {
  BmiCalculator() : super('');

  String getResult(int height, int weight) {
    debugPrint(height.toString());
    debugPrint(weight.toString());
    double bmi;
    bmi = weight / pow(height / 100, 2);
    return bmi.toStringAsFixed(1);
  }
}
