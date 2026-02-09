import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: FirstPage()));

// --- [첫 번째 페이지] ---
class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("첫 번째 페이지")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SecondPage())),
          child: const Text("두 번째 페이지로 이동"),
        ),
      ),
    );
  }
}

// --- [두 번째 페이지: 라이프사이클 감시 대상] ---
class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();
    print("📍 [SecondPage] initState: 메모리 생성");
  }

  @override
  void dispose() {
    print("📍 [SecondPage] dispose: 메모리 파괴 (뒤로가기 클릭 시)");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("두 번째 페이지")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("이 화면에서 '뒤로가기'를 누르면\n로그에 dispose가 찍힙니다.", textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("뒤로 가기"),
            ),
          ],
        ),
      ),
    );
  }
}
