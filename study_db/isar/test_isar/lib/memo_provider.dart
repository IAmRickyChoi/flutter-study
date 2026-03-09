import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'memo.dart'; // 방금 만든 모델 가져오기

// 1. 화면(UI)과 관리자를 연결해주는 전광판
final memoProvider = AsyncNotifierProvider<MemoNotifier, List<Memo>>(() {
  return MemoNotifier();
});

class MemoNotifier extends AsyncNotifier<List<Memo>> {
  late Isar isar;

  // 2. 앱 켜질 때 딱 한 번 실행 (창고 문 열고 기존 메모 가져오기)
  @override
  Future<List<Memo>> build() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        Isar.getInstance() ??
        await Isar.open([MemoSchema], directory: dir.path);

    // DB에 있는 모든 메모를 리스트로 반환
    return await isar.memos.where().findAll();
  }

  // 3. 메모 추가하기 기능
  Future<void> addMemo(String newText) async {
    final newMemo = Memo()..text = newText; // 새 메모 객체 만들기

    // DB에 쏙 집어넣기
    await isar.writeTxn(() async {
      await isar.memos.put(newMemo);
    });

    // 전광판 화면 새로고침! (UI가 이걸 보고 알아서 바뀝니다)
    state = AsyncData(await isar.memos.where().findAll());
  }
}
