import 'package:flutter/material.dart';
import 'package:flutter_practice/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloWorldProvider = Provider((_) => 'Hello World');

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// selectを使ってみる
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
    String name = ref.watch(userProvider.select((user) => user.name));
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(name),
              ElevatedButton(
                onPressed: () => ref.read(userProvider.notifier).changeName(),
                child: const Text('Name'),
              ),
              ElevatedButton(
                onPressed: () => ref.read(userProvider.notifier).changeAge(),
                child: const Text('Age'),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => ref.refresh(userProvider),
        ),
      ),
    );
  }
}
