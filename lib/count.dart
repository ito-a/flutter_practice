// テスト用のカウントアプリを作ってみた

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countProvider = StateProvider((ref) => 0);

class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Consumer(builder: (context, ref, _) {
      final counter = ref.watch(countProvider);
      return ElevatedButton(
        onPressed: () {
          ref.read(countProvider.notifier).state++;
        },
        child: Text('$counter'),
      );
    }));
  }
}
