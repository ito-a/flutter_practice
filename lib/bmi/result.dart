import 'package:flutter/material.dart';
import 'package:flutter_practice/bmi/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Result extends ConsumerWidget {
  const Result({Key? key}) : super(key: key);

  static const routeName = 'result_page';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = ref.watch(heightProvider);
    final weight = ref.watch(weightProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('BMI CALCULATOR RESULT'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '結果発表',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '性別: ${ref.watch(genderProvider).name}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ref.watch(bmiCalculatorProvider.notifier).getResult(
                    int.parse(height),
                    int.parse(weight),
                  ),
              style: const TextStyle(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
              child: const Text('再計算'),
            )
          ],
        ),
      ),
    );
  }
}
