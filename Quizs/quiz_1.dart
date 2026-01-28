// [요구사항 1] Extension: List<String>에 .toSnakeCase() 기능을 추가하세요.
//             리스트의 모든 단어를 소문자로 바꾸고 언더바(_)로 연결합니다.
//             예: ["Smart", "Home", "System"] -> "smart_home_system"

// [요구사항 2] Sealed Class: 'EditorEvent'를 정의하세요.
//             - SaveEvent (String fileName)
//             - AutoFormatEvent (int lineCount)
//             - ErrorEvent (String message)

// [요구사항 3] Generic & Mixin: 'Plugin' 인터페이스(추상 클래스)를 만들고,
//             Logger 믹스인을 활용해 이벤트를 로깅하는 'DebugPlugin'을 구현하세요.

// TODO 1: List<String> 확장 메서드 작성
extension StringListExt on List<String> {
  String toSnakeCase() => _______;
}

// TODO 2: Sealed Class EditorEvent 정의
sealed class EditorEvent {}
class SaveEvent extends EditorEvent { final String fileName; SaveEvent(this.fileName); }
class AutoFormatEvent extends EditorEvent { final int lineCount; AutoFormatEvent(this.lineCount); }
class ErrorEvent extends EditorEvent { final String message; ErrorEvent(this.message); }

// TODO 3: 패턴 매칭을 활용한 이벤트 처리기 함수 작성
String handleEvent(EditorEvent event) => switch (event) {
  _______ => "파일 '${e.fileName}' 저장 완료",
  _______ => "${e.lineCount}줄 코드 정렬 완료",
  _______ => "치명적 오류: ${e.message}",
};

void main() {
  // 테스트 1: 확장 메서드
  final words = ["Advanced", "Dart", "Pattern"];
  print("스네이크 케이스: ${words.toSnakeCase()}");

  // 테스트 2: 패턴 매칭
  final events = [SaveEvent("main.dart"), ErrorEvent("세미콜론 누락")];
  for (var e in events) {
    print(handleEvent(e));
  }
}
