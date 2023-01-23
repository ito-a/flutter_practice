import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Todoリストを作ってみよう!
class Todos {
  Todos({required this.description, required this.id, this.isCompleted = false});

  String description;
  String id;
  bool isCompleted;
}

class TodoList extends StateNotifier<List<Todos>> {
  TodoList([List<Todos>? initialTodos]) : super(initialTodos ?? []);

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todos(
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

final todoListProvider = StateNotifierProvider<TodoList, List<Todos>>((ref) {
  return TodoList([
    Todos(description: 'TEST1', id: '1'),
    Todos(description: 'TEST2', id: '2'),
    Todos(description: 'TEST3', id: '3')
  ]);
});
final filterProvider = StateProvider((ref) => Filter.all);

final filteredTodoListProvider = Provider<List<Todos>>((ref) {
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

class Todo extends ConsumerWidget {
  const Todo({Key? key}) : super(key: key);

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
