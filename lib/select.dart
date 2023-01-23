import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/user.dart';

//selectを使ってみた
final userProvider = StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(const User());

  void changeName() {
    state = state.copyWith(name: '花子');
  }

  void changeAge() {
    state = state.copyWith(age: 10);
  }
}

class Select extends ConsumerWidget {
  const Select({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String name = ref.watch(userProvider.select((user) => user.name));
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('selectを利用'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(name),
              ElevatedButton(
                onPressed: () {
                  ref.read(userProvider.notifier).changeName();
                },
                child: const Text('name'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(userProvider.notifier).changeAge();
                },
                child: const Text('age'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
