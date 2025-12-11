import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ParentScreen(),
    );
  }
}

/// [ParentScreen]
/// 자식 위젯(ChildCounter)을 가지고 있으며, 버튼을 통해 자식을 제어함
class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  // 1. GlobalKey 선언
  // 제네릭(<ChildCounterState>)을 명시해야 자식의 public 메서드에 접근 가능
  final GlobalKey<ChildCounterState> _counterKey = GlobalKey<ChildCounterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GlobalKey 연습')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('부모 위젯 영역', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            
            // 2. 자식 위젯에 키 전달
            ChildCounter(key: _counterKey),
            
            const SizedBox(height: 40),
            
            // 3. 키를 통해 자식의 메서드 직접 호출
            ElevatedButton.icon(
              onPressed: () {
                // currentState가 null이 아닐 때만 실행
                // 외부에서 자식의 setState를 유발하는 메서드를 호출함
                _counterKey.currentState?.incrementCounter();
              },
              icon: const Icon(Icons.add),
              label: const Text('자식 위젯 카운터 증가시키기'),
            ),
            
            const SizedBox(height: 10),
            
            ElevatedButton.icon(
              onPressed: () {
                _counterKey.currentState?.resetCounter();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('자식 위젯 리셋'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[100],
                foregroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// [ChildCounter]
/// 자체적인 상태(count)를 가지고 있는 자식 위젯
class ChildCounter extends StatefulWidget {
  // GlobalKey를 받을 수 있도록 생성자에 key 전달
  const ChildCounter({super.key});

  @override
  State<ChildCounter> createState() => ChildCounterState();
}

// 중요: State 클래스를 private(_)이 아닌 public으로 열어야 
// GlobalKey<ChildCounterState>로 접근 가능함
class ChildCounterState extends State<ChildCounter> {
  int _count = 0;

  // 외부(부모)에서 호출할 메서드 1
  void incrementCounter() {
    setState(() {
      _count++;
    });
  }

  // 외부(부모)에서 호출할 메서드 2
  void resetCounter() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Column(
        children: [
          const Text('여기는 자식 위젯', style: TextStyle(color: Colors.grey)),
          Text(
            '$_count',
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
