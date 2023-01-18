import 'package:flutter_riverpod/flutter_riverpod.dart';

final cityProvider = Provider((ref) => 'London');
final countryProvider = Provider((ref) => 'England');

// https://riverpod.dev/ja/docs/concepts/reading
final repositoryProvider = Provider((ref) => null);
final countProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter(ref);
});

class Counter extends StateNotifier<int> {
  Counter(this.ref) : super(0);
  final Ref ref;

  void increment() {
    final repository = ref.read(repositoryProvider);
    repository.post();
  }
}

// ref.watchを使ってみる

enum FilterType {
  none,
  completed;
}

class Todo {
  Todo({
    required this.doing,
    required this.isCompleted,
  });

  String doing;
  bool isCompleted;
}

class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);
}

final filterTypeProvider = StateProvider<FilterType>((ref) => FilterType.none);
final todosProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) => TodoList());

final filteredTodoListProvider = Provider((ref) {
  final FilterType filter = ref.watch(filterTypeProvider);
  final List<Todo> todos = ref.watch(todosProvider);

  switch (filter) {
    case FilterType.completed:
      return todos.where((todo) => todo.isCompleted).toList();
    case FilterType.none:
      return todos;
  }
});
