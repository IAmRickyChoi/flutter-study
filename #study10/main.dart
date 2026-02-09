import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const MasterApp());

class MasterApp extends StatefulWidget {
  const MasterApp({super.key});

  @override
  State<MasterApp> createState() => _MasterAppState();
}

class _MasterAppState extends State<MasterApp> {
  ThemeMode _themeMode = ThemeMode.light;
  bool _showChild = true;
  int _parentCounter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: const Text("Lifecycle Master")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 1. 테마 변경 -> didChangeDependencies 유도
              ListTile(
                title: const Text("1. 다크모드 전환"),
                trailing: Switch(
                  value: _themeMode == ThemeMode.dark,
                  onChanged: (_) => setState(() => _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light),
                ),
              ),
              // 2. 부모 카운터 변경 -> didUpdateWidget 유도
              ListTile(
                title: Text("2. 부모 데이터 변경 (현재: $_parentCounter)"),
                onTap: () => setState(() => _parentCounter++),
                trailing: const Icon(Icons.add),
              ),
              // 3. 위젯 제거/생성 -> dispose / initState 유도
              ListTile(
                title: const Text("3. 자식 위젯 파괴/생성"),
                onTap: () => setState(() => _showChild = !_showChild),
                trailing: Icon(_showChild ? Icons.visibility : Icons.visibility_off),
              ),
              const Divider(height: 50),
              if (_showChild) 
                MasterChildWidget(parentData: _parentCounter)
              else 
                const Text("자식 위젯이 메모리에서 해제됨"),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 여기서부터 진짜 공부 시작! ---
class MasterChildWidget extends StatefulWidget {
  final int parentData;
  const MasterChildWidget({super.key, required this.parentData});

  @override
  State<MasterChildWidget> createState() {
    print("👉 [1] createState: 상태 객체 생성");
    return _MasterChildWidgetState();
  }
}

// WidgetsBindingObserver를 추가하여 App Lifecycle까지 감시
class _MasterChildWidgetState extends State<MasterChildWidget> with WidgetsBindingObserver {
  
  @override
  void initState() {
    super.initState();
    // 관찰자 등록 (App Lifecycle용)
    WidgetsBinding.instance.addObserver(this);
    print("👉 [2] initState: 초기화 (이벤트 리스너 등록, 서버 요청 예약 등)");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Theme, Locale, MediaQuery 등 상위 환경이 바뀔 때 호출
    print("👉 [3] didChangeDependencies: 환경 설정(Theme 등) 확인됨");
  }

  @override
  void didUpdateWidget(covariant MasterChildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 부모로부터 받는 파라미터가 바뀌었을 때 (데이터 비교 가능)
    if (oldWidget.parentData != widget.parentData) {
      print("👉 [4] didUpdateWidget: 부모 데이터 변경 감지 (${oldWidget.parentData} -> ${widget.parentData})");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 앱이 백그라운드로 가거나 다시 켜질 때 (Home 버튼 등)
    print("📱 [App Lifecycle] 현재 앱 상태: $state");
  }

  @override
  Widget build(BuildContext context) {
    // 실제 화면을 그리는 시점
    print("👉 [5] build: UI 렌더링");
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Column(
        children: [
          const Text("나는 자식 위젯입니다", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("부모 데이터: ${widget.parentData}"),
          const SizedBox(height: 10),
          const Text("콘솔의 로그 순서를 확인하세요!", style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    // 위젯 트리에서 잠시 빠질 때
    print("👉 [6] deactivate: 위젯 트리에서 제거됨 (임시)");
    super.deactivate();
  }

  @override
  void dispose() {
    // 영구 소멸 (메모리 정리)
    WidgetsBinding.instance.removeObserver(this); // 관찰자 해제 필수!
    print("👉 [7] dispose: 메모리 해제 완료 (영구 소멸)");
    super.dispose();
  }
}
