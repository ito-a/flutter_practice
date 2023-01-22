import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloWorldProvider = Provider((_) => 'Hello World');

// Todoリストを作ってみよう!
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class Todo {
  Todo({required this.description, required this.id, this.isCompleted = false});

  String description;
  String id;
  bool isCompleted;
}

class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            isCompleted: !todo.isCompleted,
            description: todo.description,
          )
        else
          todo,
    ];
  }
}

enum Filter {
  all,
  completed,
  uncompleted,
}

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList([
    Todo(description: 'TEST1', id: '1'),
    Todo(description: 'TEST2', id: '2'),
    Todo(description: 'TEST3', id: '3')
  ]);
});
final filterProvider = StateProvider((ref) => Filter.all);

final filteredTodoListProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(filterProvider);
  final todos = ref.watch(todoListProvider);
  switch (filter) {
    case Filter.all:
      return todos;
    case Filter.completed:
      return todos.where((element) => element.isCompleted).toList();
    case Filter.uncompleted:
      return todos.where((element) => !element.isCompleted).toList();
  }
});

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredTodoList = ref.watch(filteredTodoListProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example'),
        ),
        body: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: filteredTodoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Checkbox(
                        value: filteredTodoList[index].isCompleted,
                        onChanged: (value) =>
                            ref.read(todoListProvider.notifier).toggle(filteredTodoList[index].id),
                      ),
                      Text(filteredTodoList[index].description),
                    ],
                  );
                }),
            ElevatedButton(
              onPressed: () => ref.read(filterProvider.notifier).state = Filter.all,
              child: const Text('All'),
            ),
            ElevatedButton(
              onPressed: () => ref.read(filterProvider.notifier).state = Filter.completed,
              child: const Text('Completed'),
            ),
            ElevatedButton(
              onPressed: () => ref.read(filterProvider.notifier).state = Filter.uncompleted,
              child: const Text('UnCompleted'),
            ),
            ElevatedButton(
              onPressed: () => ref.refresh(filterProvider),
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
