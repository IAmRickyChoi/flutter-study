// 이따가 명령어 치면 생길 마법의 파일입니다.
import 'package:isar_community/isar.dart';

part 'memo.g.dart';

@collection
class Memo {
  Id id = Isar.autoIncrement; // 번호표 (자동으로 1, 2, 3... 늘어남)
  String text = ''; // 메모 내용
}
