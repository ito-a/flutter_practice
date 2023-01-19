import 'package:flutter/material.dart';
import 'package:flutter_practice/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloWorldProvider = Provider((_) => 'Hello World');

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// listenを使ってみる
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

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listenUser = ref.listen(userProvider.select((user) => user.name),
        (String? previousName, String newName) {
      print('The user name changed $newName');
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => ref.read(userProvider.notifier).changeName(),
                child: const Text('Name'),
              ),
              ElevatedButton(
                onPressed: () => ref.read(userProvider.notifier).changeAge(),
                child: const Text('age'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
