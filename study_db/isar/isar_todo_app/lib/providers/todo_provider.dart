import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:isar_todo_app/models/todo.dart';
import 'package:isar_todo_app/services/isar_service.dart';

// 생성된 코드를 포함할 파일을 명시합니다.
part 'todo_provider.g.dart';

// [수정 B 반영]: 제너레이터가 생성해주는 구체적인 타입인 `IsarServiceRef` 사용
@Riverpod(keepAlive: true)
IsarService isarService(Ref ref) {
  return IsarService();
}

// [수정 A 반영]: DB 변경을 실시간으로 감지하는 StreamNotifier 패턴으로 변경
@riverpod
class TodoList extends _$TodoList {
  @override
  Stream<List<Todo>> build() {
    // 기존의 getAllTodos()(Future) 대신 watchTodos()(Stream)를 반환합니다.
    return ref.watch(isarServiceProvider).watchTodos();
  }

  // 새로운 Todo를 추가하는 메서드입니다.
  Future<void> addTodo(String title) async {
    final isarService = ref.read(isarServiceProvider);

    final newTodo = Todo()..title = title;
    await isarService.createTodo(newTodo);

    // ✨ Isar의 Stream이 DB 변경을 자동으로 감지하여 UI를 업데이트하므로
    // ref.invalidateSelf(); 가 더 이상 필요하지 않아 삭제했습니다.
  }

  // Todo의 완료 상태를 토글하는 메서드입니다.
  Future<void> toggleTodo(Todo todo) async {
    final isarService = ref.read(isarServiceProvider);

    todo.isCompleted = !todo.isCompleted;
    await isarService.updateTodo(todo);

    // ✨ 수동 상태 갱신 코드 삭제
  }

  // Todo를 삭제하는 메서드입니다.
  Future<void> deleteTodo(int id) async {
    final isarService = ref.read(isarServiceProvider);

    await isarService.deleteTodo(id);

    // ✨ 수동 상태 갱신 코드 삭제
  }
}
