import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/bmi/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Top extends ConsumerWidget {
  const Top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onPressed: () {},
                child: const Text('MALE'),
              ),
              ElevatedButton(
                onPressed: () {},
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
                MaterialPageRoute(builder: (context) => Result()),
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
