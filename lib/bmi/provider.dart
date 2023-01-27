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
    StateNotifierProvider<BmiCalculatorController, String>((ref) => BmiCalculatorController());

class BmiCalculatorController extends StateNotifier<String> {
  BmiCalculatorController() : super("");

  String getResult(int height, int weight) {
    double bmi;
    bmi = weight / pow(height / 100, 2);
    return bmi.toStringAsFixed(1);
  }

  void input(String text) {
    state = text;
  }
}
