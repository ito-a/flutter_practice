import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class Repository {
  Future<List<Todos>> fetchTodos() async => [];
}

class Todos {
  Todos({
    required this.description,
    required this.id,
    required this.isCompleted,
  });

  String description;
  String id;
  bool isCompleted;
}

final repositoryProvider = Provider((ref) => Repository());

final todoListProvider = FutureProvider((ref) async {
  final repository = ref.read(repositoryProvider);
  return repository.fetchTodos();
});

class FakeRepository implements Repository {
  @override
  Future<List<Todos>> fetchTodos() async {
    return [
      Todos(id: '42', description: 'Hello world', isCompleted: false),
    ];
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem({Key? key, required this.todos}) : super(key: key);
  final Todos todos;

  @override
  Widget build(BuildContext context) {
    return Text(todos.description);
  }
}

void main() {
  testWidgets('override repositoryProvider', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [repositoryProvider.overrideWithValue(FakeRepository())],
        child: MaterialApp(
          home: Scaffold(
            body: Consumer(builder: (context, ref, _) {
              final todos = ref.watch(todoListProvider);
              if (todos.asData == null) {
                return const CircularProgressIndicator();
              }
              return ListView(
                children: [
                  for (final todo in todos.asData!.value)
                    TodoItem(
                      todos: todo,
                    )
                ],
              );
            }),
          ),
        ),
      ),
    );

    // 最初のフレームのステートが loading になっているか確認
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // 再描画。このあたりで TodoListProvider は 値の取得が終わっているはず
    await tester.pump();

    // loading 以外のステートになっているか確認
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // FakeRepository が公開した値から TodoItem が一つ描画されているか確認
    expect(tester.widgetList(find.byType(TodoItem)), [
      isA<TodoItem>()
          .having((s) => s.todos.id, 'todo.id', '42')
          .having((s) => s.todos.description, 'todo.label', 'Hello world')
          .having((s) => s.todos.isCompleted, 'todo.completed', false),
    ]);
  });
}
