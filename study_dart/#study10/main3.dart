import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: FirstPage()));

// ==============================================================================
// 1. [첫 번째 페이지] : 데이터를 기다리는 메인 화면 (AppLifecycle 감지)
// ==============================================================================
class FirstPage extends StatefulWidget {
  // [0] 생성자
  FirstPage({super.key}) {
    print("🏠 [Page1] 0. Constructor (페이지 생성)");
  }

  @override
  State<FirstPage> createState() {
    print("🏠 [Page1] 1. createState");
    return _FirstPageState();
  }
}

class _FirstPageState extends State<FirstPage> with WidgetsBindingObserver {
  String _dataFromPage2 = "아직 데이터 없음";

  @override
  void initState() {
    super.initState();
    // 앱 상태 변화 감지 등록
    WidgetsBinding.instance.addObserver(this);
    print("🏠 [Page1] 2. initState (초기화 - 메모리 등록)");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("🏠 [Page1] 3. didChangeDependencies (의존성 확인)");
  }

  @override
  void didUpdateWidget(covariant FirstPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 부모(MaterialApp)가 재빌드될 때 호출됨
    print("🏠 [Page1] didUpdateWidget");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 앱을 백그라운드로 보낼 때 등
    print("📱 [App Lifecycle] 상태 변경: $state");
  }

  // [핵심 로직] 2번 페이지로 갔다가 데이터를 받아오는 함수
  Future<void> _navigateAndFetchData() async {
    print("\n🚀 [Navigation] 2번 페이지로 Push (대기 모드 시작)");
    
    // await를 사용하여 2번 페이지가 꺼질 때까지 기다림
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage()),
    );

    // 2번 페이지가 꺼진 후(Pop) 실행됨
    if (result != null) {
      print("📩 [Page1] 데이터 수신: $result -> setState 호출");
      setState(() {
        _dataFromPage2 = result; // 상태 변경 -> 화면 갱신(Rebuild) 유발
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("🏠 [Page1] 4. build (화면 그리기)");
    return Scaffold(
      appBar: AppBar(title: const Text("1번 페이지 (Receiver)")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("2번 페이지에서 온 데이터:", style: TextStyle(color: Colors.grey)),
            Text(_dataFromPage2, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            
            const SizedBox(height: 30),
            
            // 자식 위젯에게 데이터 전달 (Update 테스트용)
            ChildWidget(message: _dataFromPage2),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _navigateAndFetchData,
              child: const Text("2번 페이지로 이동 (Push)"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print("🏠 [Page1] 5. deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print("🏠 [Page1] 6. dispose (소멸)");
    super.dispose();
  }
}

// ==============================================================================
// 2. [자식 위젯] : 1번 페이지 안에서 데이터 변화를 감지하는 녀석
// ==============================================================================
class ChildWidget extends StatefulWidget {
  final String message;

  // Page1이 setState 할 때마다 이 생성자는 호출됩니다.
  ChildWidget({super.key, required this.message}) {
    print("  👶 [자식] 0. Constructor (새 설계도 도착: $message)");
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
    // [중요] 부모가 넘겨준 데이터가 바뀌었는지 확인하는 곳
    if (oldWidget.message != widget.message) {
      print("  👶 [자식] 4. didUpdateWidget: 데이터 변경 감지! (${oldWidget.message} -> ${widget.message})");
    } else {
      print("  👶 [자식] 4. didUpdateWidget: 데이터 변경 없음");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("  👶 [자식] 5. build");
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.blue[50],
      child: Text("자식 위젯 상태: ${widget.message}"),
    );
  }

  @override
  void deactivate() {
    print("  👶 [자식] 6. deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("  👶 [자식] 7. dispose");
    super.dispose();
  }
}

// ==============================================================================
// 3. [두 번째 페이지] : 데이터를 만들어서 돌려주는 역할 (Sender)
// ==============================================================================
class SecondPage extends StatefulWidget {
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
  Widget build(BuildContext context) {
    print("📄 [Page2] 4. build (화면 그리기)");
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(title: const Text("2번 페이지 (Sender)"), backgroundColor: Colors.orange),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("데이터를 가지고 돌아갑니다."),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("\n🔙 [Navigation] 데이터 전달 및 Pop");
                // 이전 페이지로 데이터("Hello World")를 전달하며 종료
                Navigator.pop(context, "Hello World! 🎉");
              },
              child: const Text("데이터 전달하고 종료 (Pop)"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print("📄 [Page2] 5. deactivate (화면에서 사라짐)");
    super.deactivate();
  }

  @override
  void dispose() {
    print("📄 [Page2] 6. dispose (완전 파괴)");
    super.dispose();
  }
}
