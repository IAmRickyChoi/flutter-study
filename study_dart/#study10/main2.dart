import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ParentPage()));

// ==============================================================================
// 1. [부모 페이지] : 앱의 메인 화면, 자식 관리, 네비게이션 시작점
// ==============================================================================
class ParentPage extends StatefulWidget {
  // [0] 생성자: 위젯 클래스(설계도)가 인스턴스화 될 때 가장 먼저 실행
  ParentPage({super.key}) {
    print("👨 [부모] 0. Constructor (생성자 호출)");
  }

  @override
  State<ParentPage> createState() {
    print("👨 [부모] 1. createState (상태 객체 생성)");
    return _ParentPageState();
  }
}

class _ParentPageState extends State<ParentPage> with WidgetsBindingObserver {
  int _counter = 0;
  bool _showChild = true;

  @override
  void initState() {
    super.initState();
    // 앱 상태 변화 감지를 위해 옵저버 등록
    WidgetsBinding.instance.addObserver(this);
    print("👨 [부모] 2. initState (초기화)");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("👨 [부모] 3. didChangeDependencies (의존성 변화)");
  }

  @override
  void didUpdateWidget(covariant ParentPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 부모의 부모(예: MaterialApp)가 재빌드되어 이 위젯을 갱신할 때 호출됨
    print("👨 [부모] didUpdateWidget (상위 위젯에 의해 갱신됨)");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 앱 전체의 상태 (백그라운드/포그라운드)
    print("📱 [App Lifecycle] 상태 변경: $state");
  }

  @override
  Widget build(BuildContext context) {
    print("👨 [부모] 4. build (화면 그리기)");
    return Scaffold(
      appBar: AppBar(title: const Text("Lifecycle Total Guide")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_showChild)
              ChildWidget(counter: _counter) // 자식 위젯
            else
              const Text("⚠️ 자식 위젯이 제거됨 (Dispose)", style: TextStyle(color: Colors.red)),
            
            const Divider(height: 30, thickness: 2),
            
            // 버튼 1: 자식에게 데이터 전달 (Update 유도)
            ElevatedButton(
              onPressed: () {
                print("\n🔄 [부모] setState -> 데이터 변경");
                setState(() => _counter++);
              },
              child: const Text("1. 자식 데이터 변경 (Update)"),
            ),
            
            // 버튼 2: 자식 제거/생성 (Dispose/Init 유도)
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[100]),
              onPressed: () {
                print("\n🗑️ [부모] setState -> 자식 제거/생성");
                setState(() => _showChild = !_showChild);
              },
              child: const Text("2. 자식 끄기/켜기"),
            ),

            // 버튼 3: 페이지 이동 (Navigation Push)
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[100]),
              onPressed: () {
                print("\n🚀 [네비게이션] 2번 페이지로 Push");
                Navigator.push(context, MaterialPageRoute(builder: (_) => SecondPage()));
              },
              child: const Text("3. 2번 페이지로 이동"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print("👨 [부모] 5. deactivate (트리에서 잠시 이탈)");
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print("👨 [부모] 6. dispose (완전 소멸)");
    super.dispose();
  }
}

// ==============================================================================
// 2. [자식 위젯] : 부모 안에 살고 있는 위젯 (Update 관찰용)
// ==============================================================================
class ChildWidget extends StatefulWidget {
  final int counter;

  // [중요] 부모가 setState를 하면 이 생성자는 '매번' 호출됩니다.
  ChildWidget({super.key, required this.counter}) {
    print("  👶 [자식] 0. Constructor (새 설계도 도착: $counter)");
  }

  @override
  State<ChildWidget> createState() {
    print("  👶 [자식] 1. createState (최초 1회)");
    return _ChildWidgetState();
  }
}

class _ChildWidgetState extends State<ChildWidget> {
  @override
  void initState() {
    super.initState();
    print("  👶 [자식] 2. initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("  👶 [자식] 3. didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant ChildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // [핵심] State는 그대로고, Widget(설계도)만 바뀌었을 때 호출
    if (oldWidget.counter != widget.counter) {
      print("  👶 [자식] 4. didUpdateWidget: 데이터 변경됨 (${oldWidget.counter} -> ${widget.counter})");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("  👶 [자식] 5. build");
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue),
      ),
      child: Text("자식 카운터: ${widget.counter}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  @override
  void deactivate() {
    print("  👶 [자식] 6. deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("  👶 [자식] 7. dispose (메모리 해제)");
    super.dispose();
  }
}

// ==============================================================================
// 3. [두 번째 페이지] : 네비게이션 스택 위에 쌓이는 페이지 (Stateful로 변경됨!)
// ==============================================================================
class SecondPage extends StatefulWidget {
  // 생성자
  SecondPage({super.key}) {
    print("📄 [Page2] 0. Constructor (페이지 생성)");
  }

  @override
  State<SecondPage> createState() {
    print("📄 [Page2] 1. createState");
    return _SecondPageState();
  }
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();
    print("📄 [Page2] 2. initState (새 화면 진입)");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("📄 [Page2] 3. didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant SecondPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 이 예제에서는 SecondPage의 부모가 재빌드될 일이 적어 잘 안 불리지만, 구조상 존재함
    print("📄 [Page2] 4. didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    print("📄 [Page2] 5. build (화면 그리기)");
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(title: const Text("2번 페이지 (Stateful)"), backgroundColor: Colors.orange),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("여기는 2번 페이지입니다.\n1번 페이지는 뒤에 살아있습니다!", textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("\n🔙 [네비게이션] 뒤로가기 (Pop)");
                Navigator.pop(context);
              },
              child: const Text("뒤로 가기 (Dispose 유발)"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print("📄 [Page2] 6. deactivate (화면에서 사라짐)");
    super.deactivate();
  }

  @override
  void dispose() {
    print("📄 [Page2] 7. dispose (완전 파괴)");
    super.dispose();
  }
}
