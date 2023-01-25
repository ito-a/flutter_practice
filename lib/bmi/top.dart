import 'package:flutter/material.dart';
import 'package:flutter_practice/bmi/provider.dart';
import 'package:flutter_practice/bmi/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Top extends ConsumerWidget {
  const Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gender = ref.watch(genderProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: gender == Gender.male ? Colors.pink : Colors.blue,
                ),
                onPressed: () {
                  ref.read(genderProvider.notifier).state = Gender.male;
                },
                child: const Text('MALE'),
              ),
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: gender == Gender.female ? Colors.pink : Colors.blue,
                ),
                onPressed: () {
                  ref.read(genderProvider.notifier).state = Gender.female;
                },
                child: const Text('FEMALE'),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Text('身長 (cm)'),
                TextField(
                  onChanged: (value) => {ref.read(heightProvider.notifier).state = value},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Text('体重 (kg)'),
                TextField(
                  onChanged: (value) => {ref.read(weightProvider.notifier).state = value},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Result()),
              );
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.pink,
            ),
            child: const Text('計算する'),
          )
        ],
      ),
    );
  }
}
