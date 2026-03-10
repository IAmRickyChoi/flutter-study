import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar_todo_app/models/todo.dart';

// Isar 데이터베이스 작업을 처리하는 서비스 클래스입니다.
class IsarService {
  // IsarService의 싱글톤 인스턴스를 생성합니다.
  // 앱 전체에서 단 하나의 IsarService 객체만 사용하도록 보장합니다.
  static final IsarService _instance = IsarService._internal();
  factory IsarService() => _instance;
  IsarService._internal();

  late Future<Isar> db;

  // 데이터베이스를 초기화하는 메서드입니다.
  // 앱이 시작될 때 한 번만 호출되어야 합니다.
  Future<void> init() async {
    db = Future(() async {
      // path_provider를 사용하여 Isar 데이터베이스 파일을 저장할 안전한 디렉토리를 찾습니다.
      final dir = await getApplicationDocumentsDirectory();
      
      // Isar 인스턴스를 엽니다. TodoSchema가 Isar에 등록되어 이 타입의 객체를 저장할 수 있게 됩니다.
      // inspector: true는 디버그 모드에서 Isar Inspector를 활성화하여 데이터베이스를 시각적으로 탐색할 수 있게 해줍니다.
      return Isar.open(
        [TodoSchema],
        directory: dir.path,
        inspector: true,
      );
    });
  }

  // 데이터베이스에 새로운 할 일(Todo)을 추가하는 메서드입니다.
  Future<void> createTodo(Todo newTodo) async {
    final isar = await db;
    // Isar 트랜잭션(transaction) 내에서 데이터베이스 쓰기 작업을 수행합니다.
    // 트랜잭션은 데이터의 일관성과 무결성을 보장합니다.
    isar.writeTxnSync(() => isar.todos.putSync(newTodo));
  }

  // 데이터베이스에 있는 모든 할 일 목록을 가져오는 메서드입니다.
  Future<List<Todo>> getAllTodos() async {
    final isar = await db;
    // .where().findAll()을 사용하여 Todo 컬렉션의 모든 객체를 조회합니다.
    return await isar.todos.where().findAll();
  }

  // 특정 할 일의 완료 상태를 업데이트하는 메서드입니다.
  Future<void> updateTodo(Todo todo) async {
    final isar = await db;
    // 기존 할 일을 수정할 때도 put 메서드를 사용합니다.
    // Isar는 id를 기준으로 기존 객체를 찾아 업데이트합니다.
    isar.writeTxnSync(() => isar.todos.putSync(todo));
  }

  // 데이터베이스에서 특정 할 일을 삭제하는 메서드입니다.
  Future<void> deleteTodo(int id) async {
    final isar = await db;
    // id를 기준으로 삭제할 객체를 찾아 삭제합니다.
    isar.writeTxnSync(() => isar.todos.deleteSync(id));
  }
  
  // Todo 컬렉션에 변경이 있을 때마다 알려주는 Stream을 반환합니다.
  // 이를 통해 UI가 데이터베이스 변경에 실시간으로 반응할 수 있습니다.
  Stream<List<Todo>> watchTodos() async* {
    final isar = await db;
    // isar.todos.where().watch()는 컬렉션의 변화를 감지하는 스트림을 생성합니다.
    // fireImmediately: true는 스트림이 시작될 때 현재 데이터를 즉시 반환하도록 합니다.
    await for (final todos in isar.todos.where().watch(fireImmediately: true)) {
      yield todos;
    }
  }
}
