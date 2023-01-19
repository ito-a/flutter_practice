import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloWorldProvider = Provider((_) => 'Hello World');

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final cityProvider = StateProvider((ref) => '');

// プロバイダのステートを組み合わせる
final weatherProvider = FutureProvider((ref) {
  final city = ref.watch(cityProvider);
  return fetchWeather(city);
});

String fetchWeather(String city) {
  switch (city) {
    case 'London':
      return '晴れ';
    case 'Paris':
      return '曇り';
    case 'Roma':
      return '雨';
  }
  return ' 各都市の天気はなんでしょう?';
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue weather = ref.watch(weatherProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example'),
        ),
        body: Column(
          children: [
            weather.when(
              data: (value) {
                return Text(value);
              },
              error: (err, stack) => Text('Error: $err'),
              loading: () => const CircularProgressIndicator(),
            ),
            ElevatedButton(
              onPressed: () => ref.read(cityProvider.notifier).state = 'London',
              child: const Text('London'),
            ),
            ElevatedButton(
              onPressed: () => ref.read(cityProvider.notifier).state = 'Paris',
              child: const Text('Paris'),
            ),
            ElevatedButton(
              onPressed: () => ref.refresh(cityProvider),
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
