import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloWorldProvider = Provider((_) => 'Hello World');

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// StreamProviderを使ってみる
final userProvider = StreamProvider((ref) {
  Stream<dynamic> getNumbers() async* {
    await Future.delayed(const Duration(seconds: 1));
    yield 'Are You Ready?';

    await Future.delayed(const Duration(seconds: 1));
    yield 3;

    await Future.delayed(const Duration(seconds: 1));
    yield 2;

    await Future.delayed(const Duration(seconds: 1));
    yield 1;
  }

  return getNumbers();
});

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue asyncValue = ref.watch(userProvider); //Stream の現在のステートを同期的に取得する
    Stream userStream = ref.watch(userProvider.stream);
    userStream.listen((event) {
      // print(event);
    });
    Future userFuture = ref.watch(userProvider.future);
    userFuture.then((value) => print(value));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example'),
        ),
        body: Center(),
      ),
    );
  }
}
