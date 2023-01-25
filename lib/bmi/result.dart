import 'package:flutter/material.dart';
import 'package:flutter_practice/bmi/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Result extends ConsumerWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = ref.watch(heightProvider);
    final weight = ref.watch(weightProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR Result'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Result',
              style: TextStyle(fontSize: 24),
            ),
            Text(ref.watch(genderProvider).name),
            Text(
              ref.watch(bmiCalculatorProvider.notifier).getResult(
                    int.parse(height),
                    int.parse(weight),
                  ),
              style: const TextStyle(fontSize: 48),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
              child: const Text('再計算する'),
            )
          ],
        ),
      ),
    );
  }
}
