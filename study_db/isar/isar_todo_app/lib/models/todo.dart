import 'package:isar_community/isar.dart';

// `part 'todo.g.dart';`는 Isar 생성기가 이 파일을 위해 생성할 파일명을 명시합니다.
// Isar는 이 파일을 사용하여 Todo 객체를 데이터베이스에 저장하고 조회하는 데 필요한 코드를 생성합니다.
part 'todo.g.dart';

// @collection 어노테이션은 이 클래스가 Isar 데이터베이스에 저장될 컬렉션(테이블과 유사)임을 나타냅니다.
@collection
class Todo {
  // Id 타입은 Isar 컬렉션의 모든 객체에 대해 고유한 기본 키(Primary Key)입니다.
  // Isar는 자동으로 증가하는 정수 ID를 할당해줍니다.
  Id id = Isar.autoIncrement;

  // 할 일의 제목을 저장하는 필드입니다.
  late String title;

  // 할 일의 완료 여부를 저장하는 필드입니다.
  // 기본값은 false (미완료)입니다.
  bool isCompleted = false;
}
