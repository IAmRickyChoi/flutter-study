import 'package:flutter/material.dart';

void main() => runApp(const LifecycleMasterApp());

// ==============================================================================
// 0. [Root App] : 앱 전역 상태 및 시스템 설정 변경 감지
// ==============================================================================
class LifecycleMasterApp extends StatefulWidget {
  const LifecycleMasterApp({super.key});

  @override
  State<LifecycleMasterApp> createState() => _LifecycleMasterAppState();
}

class _LifecycleMasterAppState extends State<LifecycleMasterApp> with WidgetsBindingObserver {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // 앱 생명주기 감지 등록
    print("🌍 [Root] 2. initState");
  }

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  // [시스템 이벤트] 화면 회전, 키보드 등장 시
  @override
  void didChangeMetrics() {
    print("🌍 [Root] didChangeMetrics (화면 크기/회전 변경)");
  }

  // [시스템 이벤트] 시스템 언어 변경 시
  @override
  void didChangeLocales(List<Locale>? locales) {
    print("🌍 [Root] didChangeLocales (언어 변경): $locales");
  }

  // [시스템 이벤트] 시스템 테마(다크모드) 변경 시
  @override
  void didChangePlatformBrightness() {
    print("🌍 [Root] didChangePlatformBrightness (시스템 밝기 변경)");
  }

  // [시스템 이벤트] 메모리 부족 경고
  @override
  void didHaveMemoryPressure() {
    print("🚨 [Root] didHaveMemoryPressure (메모리 부족 경고!)");
  }

  // [앱 상태] 포그라운드 <-> 백그라운드
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("🌍 [Root] didChangeAppLifecycleState: $state");
  }

  // [개발용] Hot Reload 시 호출
  @override
  void reassemble() {
    super.reassemble();
    print("🌍 [Root] reassemble (Hot Reload)");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lifecycle All-In-One',
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: ParentPage(onThemeChanged: toggleTheme),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print("🌍 [Root] 6. dispose");
    super.dispose();
  }
}

// ==============================================================================
// 1. [Parent Page] : 모든 기능의 제어 센터
// ==============================================================================
class ParentPage extends StatefulWidget {
  final VoidCallback onThemeChanged;

  ParentPage({super.key, required this.onThemeChanged}) {
    print("🏠 [Parent] 0. Constructor");
  }

  @override
  State<ParentPage> createState() {
    print("🏠 [Parent] 1. createState");
    return _ParentPageState();
  }
}

class _ParentPageState extends State<ParentPage> with WidgetsBindingObserver {
  int _counter = 0;
  String _dataFromPage2 = "없음";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print("🏠 [Parent] 2. initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("🏠 [Parent] 3. didChangeDependencies (테마 등 변경)");
  }

  @override
  void didUpdateWidget(covariant ParentPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("🏠 [Parent] 4. didUpdateWidget (상위 위젯 갱신됨)");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("🏠 [Parent] reassemble (Hot Reload)");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("📱 [App Lifecycle] 상태 변경: $state");
  }

  Future<void> _goSecondPage() async {
    print("\n🚀 [Nav] 2번 페이지로 이동 (Push)");
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage()),
    );

    if (result != null) {
      print("📩 [Parent] 데이터 수신: $result -> setState 호출");
      setState(() {
        _dataFromPage2 = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("🏠 [Parent] 5. build");
    return Scaffold(
      appBar: AppBar(title: const Text("Lifecycle Complete")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // [A] 일반 자식
              NormalChildWidget(counter: _counter),
              const SizedBox(height: 20),
              // [B] Const 자식
              const ConstChildWidget(),
              const Divider(height: 40, thickness: 2),
              Text("Page2 데이터: $_dataFromPage2"),
              const SizedBox(height: 20),
              
              Wrap(
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print("\n🔄 [Action] 값 변경 -> didUpdateWidget 유도");
                      setState(() => _counter++);
                    },
                    child: const Text("1. 값 변경 (+1)"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print("\n🎨 [Action] 테마 변경 -> didChangeDependencies 유도");
                      widget.onThemeChanged();
                    },
                    child: const Text("2. 테마 변경"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[100]),
                    onPressed: _goSecondPage,
                    child: const Text("3. 페이지 이동"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print("🏠 [Parent] 6. deactivate (트리 이탈)");
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print("🏠 [Parent] 7. dispose (소멸)");
    super.dispose();
  }
}

// ==============================================================================
// 2. [Normal Child] : 값 변경 시 didUpdateWidget 호출됨
// ==============================================================================
class NormalChildWidget extends StatefulWidget {
  final int counter;

  NormalChildWidget({super.key, required this.counter}) {
    print("  👶 [Normal] 0. Constructor ($counter)");
  }

  @override
  State<NormalChildWidget> createState() {
    print("  👶 [Normal] 1. createState");
    return _NormalChildWidgetState();
  }
}

class _NormalChildWidgetState extends State<NormalChildWidget> {
  @override
  void initState() {
    super.initState();
    print("  👶 [Normal] 2. initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("  👶 [Normal] 3. didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant NormalChildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("  👶 [Normal] 4. didUpdateWidget 호출");
    if (oldWidget.counter != widget.counter) {
      print("     -> ✅ 값 변경됨 (${oldWidget.counter} -> ${widget.counter})");
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    print("  👶 [Normal] reassemble");
  }

  @override
  Widget build(BuildContext context) {
    print("  👶 [Normal] 5. build");
    return Container(
      padding: const EdgeInsets.all(15),
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Text("Normal Child: ${widget.counter}"),
    );
  }

  @override
  void deactivate() {
    print("  👶 [Normal] 6. deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("  👶 [Normal] 7. dispose");
    super.dispose();
  }
}

// ==============================================================================
// 3. [Const Child] : 최적화됨 (로그가 적게 찍힘)
// ==============================================================================
class ConstChildWidget extends StatefulWidget {
  const ConstChildWidget({super.key}); // Const 생성자

  @override
  State<ConstChildWidget> createState() => _ConstChildWidgetState();
}

class _ConstChildWidgetState extends State<ConstChildWidget> {
  @override
  void initState() {
    super.initState();
    // Const라도 최초 1회는 실행
    print("  💎 [Const] 2. initState"); 
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Const라도 테마가 바뀌면 호출됨!
    print("  💎 [Const] 3. didChangeDependencies (테마 변경 시 호출)");
  }

  @override
  void didUpdateWidget(covariant ConstChildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 이 로그는 절대 찍히면 안 됨 (Const 최적화)
    print("  💎 [Const] 4. didUpdateWidget (호출되면 버그)");
  }

  @override
  void reassemble() {
    super.reassemble();
    // Const라도 Hot Reload는 피해갈 수 없음
    print("  💎 [Const] reassemble");
  }

  @override
  Widget build(BuildContext context) {
    print("  💎 [Const] 5. build (테마 변경 시에만 실행)");
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.green[50],
      child: const Text("Const Child"),
    );
  }

  @override
  void deactivate() {
    print("  💎 [Const] 6. deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("  💎 [Const] 7. dispose");
    super.dispose();
  }
}

// ==============================================================================
// 4. [Second Page] : 네비게이션용
// ==============================================================================
class SecondPage extends StatefulWidget {
  SecondPage({super.key}) {
    print("📄 [Page2] 0. Constructor");
  }

  @override
  State<SecondPage> createState() {
    print("📄 [Page2] 1. createState");
    return _SecondPageState();
  }
}

class _SecondPageState extends State<SecondPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // 회전 등 감지
    print("📄 [Page2] 2. initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("📄 [Page2] 3. didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant SecondPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("📄 [Page2] 4. didUpdateWidget");
  }

  // 화면 회전 시 호출
  @override
  void didChangeMetrics() {
    print("📄 [Page2] didChangeMetrics (화면 회전 등)");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("📄 [Page2] reassemble");
  }

  @override
  Widget build(BuildContext context) {
    print("📄 [Page2] 5. build");
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(title: const Text("2번 페이지"), backgroundColor: Colors.orange),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print("\n🔙 [Nav] 데이터 전달 및 Pop");
            Navigator.pop(context, "Hello World!");
          },
          child: const Text("데이터 가지고 돌아가기"),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print("📄 [Page2] 6. deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print("📄 [Page2] 7. dispose");
    super.dispose();
  }
}
