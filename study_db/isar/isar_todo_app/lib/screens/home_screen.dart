import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_todo_app/models/todo.dart';
import 'package:isar_todo_app/providers/todo_provider.dart';

// HomeScreen은 ConsumerWidget을 상속받아 Riverpod의 상태를 소비(사용)합니다.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch를 사용하여 todoListProvider의 상태를 감시합니다.
    // provider의 상태가 변경되면 이 위젯은 자동으로 다시 빌드됩니다.
    final asyncTodos = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Isar & Riverpod Todo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // AsyncValue를 처리하기 위한 when 메서드를 사용합니다.
      // 데이터 로딩, 에러 발생, 데이터 수신 성공 세 가지 상태에 따라 다른 위젯을 보여줍니다.
      body: asyncTodos.when(
        data: (todos) => _buildTodoList(context, todos, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  // Todo 리스트를 보여주는 위젯을 빌드하는 메서드입니다.
  Widget _buildTodoList(BuildContext context, List<Todo> todos, WidgetRef ref) {
    if (todos.isEmpty) {
      return const Center(
        child: Text(
          '할 일이 없습니다.\n새로운 할 일을 추가해보세요!',
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
          // 할 일의 완료 여부에 따라 체크박스와 텍스트 스타일을 변경합니다.
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (value) {
              // ref.read(...).notifier()를 통해 Notifier의 메서드를 호출합니다.
              // 여기서는 toggleTodo를 호출하여 할 일의 상태를 변경합니다.
              ref.read(todoListProvider.notifier).toggleTodo(todo);
            },
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: todo.isCompleted ? Colors.grey : null,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // deleteTodo를 호출하여 할 일을 삭제합니다.
              ref.read(todoListProvider.notifier).deleteTodo(todo.id);
            },
          ),
        );
      },
    );
  }

  // 새로운 할 일을 추가하기 위한 다이얼로그를 보여주는 메서드입니다.
  void _showAddTodoDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('새로운 할 일 추가'),
          content: TextField(
            controller: textController,
            autofocus: true,
            decoration: const InputDecoration(hintText: '할 일을 입력하세요'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                final title = textController.text.trim();
                if (title.isNotEmpty) {
                  // addTodo를 호출하여 새로운 할 일을 추가합니다.
                  ref.read(todoListProvider.notifier).addTodo(title);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('추가'),
            ),
          ],
        );
      },
    );
  }
}
