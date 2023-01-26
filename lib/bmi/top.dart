import 'package:flutter/material.dart';
import 'package:flutter_practice/bmi/provider.dart';
import 'package:flutter_practice/bmi/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Top extends ConsumerWidget {
  const Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gender = ref.watch(genderProvider);
    final heightController = TextEditingController();
    final wightController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                key: const Key('gender_male_button'),
                style: OutlinedButton.styleFrom(
                  backgroundColor: gender == Gender.male ? Colors.pink : Colors.grey,
                ),
                onPressed: () {
                  ref.read(genderProvider.notifier).state = Gender.male;
                },
                child: const Text('MALE'),
              ),
              Container(
                width: 24,
              ),
              ElevatedButton(
                key: const Key('gender_female_button'),
                style: OutlinedButton.styleFrom(
                  backgroundColor: gender == Gender.female ? Colors.pink : Colors.grey,
                ),
                onPressed: () {
                  ref.read(genderProvider.notifier).state = Gender.female;
                },
                child: const Text('FEMALE'),
              ),
            ],
          ),
          Container(
            width: 120,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    '身長 (cm)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  key: const ValueKey('height_text'),
                  controller: heightController,
                  onChanged: (value) => {
                    ref.read(heightProvider.notifier).state = value,
                    heightController.text = ref.watch(heightProvider.notifier).state,
                    heightController.selection = TextSelection.fromPosition(
                      TextPosition(offset: heightController.text.length),
                    ),
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: '0',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 120,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    '体重 (kg)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  key: const ValueKey('weight_text'),
                  controller: wightController,
                  onChanged: (value) => {
                    ref.read(weightProvider.notifier).state = value,
                    wightController.text = ref.watch(weightProvider.notifier).state,
                    wightController.selection = TextSelection.fromPosition(
                      TextPosition(offset: wightController.text.length),
                    ),
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: '0',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            key: const Key('calculator_button'),
            onPressed: () {
              Navigator.pushNamed(
                context,
                Result.routeName,
              );
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.pink,
            ),
            child: const Text('計算する'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          ref.refresh(heightProvider);
          ref.refresh(weightProvider);
        },
      ),
    );
  }
}
