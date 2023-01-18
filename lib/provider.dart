import 'package:flutter_riverpod/flutter_riverpod.dart';

final cityProvider = Provider((ref) => 'London');
final countryProvider = Provider((ref) => 'England');

// https://riverpod.dev/ja/docs/concepts/reading
final countProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter(ref);
});

class Counter extends StateNotifier<int> {
  Counter(this.ref) : super(0);
  final Ref ref;
  
  void increment(){
    // countProviderはrefによりrepositoryProviderを使えるようになった
    final repository = ref.read(repositoryProvider);
    repository.post();
  }
}
