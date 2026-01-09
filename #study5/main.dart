import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: ScreenA(), debugShowCheckedModeBanner: false));
}

// --- 화면 A: 메모 리스트 ---
class ScreenA extends StatefulWidget {
  const ScreenA({super.key});

  @override
  State<ScreenA> createState() => _ScreenAState();
}

class _ScreenAState extends State<ScreenA> {
  // 메모 데이터를 담을 리스트 (각 항목은 Map 형태)
  // 예: {'content': '공부하자', 'time': 15}
  final List<Map<String, dynamic>> _memos = [];

  Future<void> _addMemo() async {
    // TODO: ScreenB로 이동하고 Map 데이터를 기다리세요.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScreenB()),
    );

    // TODO: result가 null이 아니면 _memos 리스트에 추가하고 화면을 갱신하세요.
    if (result is Map<String, dynamic>) setState(() => _memos.add(result));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('나의 타임 메모')),
      body: _memos.isEmpty
          ? const Center(child: Text('작성된 메모가 없습니다.'))
          : ListView.builder(
              itemCount: _memos.length,
              itemBuilder: (context, index) {
                final memo = _memos[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.note)),
                  title: Text(memo['content'] ?? ''),
                  subtitle: Text('작성 소요 시간: ${memo['time']}초'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMemo,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// --- 화면 B: 메모 작성기 ---
class ScreenB extends StatefulWidget {
  const ScreenB({super.key});

  @override
  State<ScreenB> createState() => _ScreenBState();
}

class _ScreenBState extends State<ScreenB> {
  // 텍스트 입력을 제어하는 컨트롤러
  late TextEditingController _controller;
  int _seconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // TODO: 컨트롤러를 초기화하세요.
    _controller = TextEditingController();
    // TODO: 1초마다 _seconds를 올리는 타이머를 시작하세요.
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: [중요] 컨트롤러를 해제(dispose)하세요.
    // TODO: [중요] 타이머를 해제(cancel)하세요.
    _controller.dispose;
    _timer?.cancel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('메모 작성 중')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('작성 시간: $_seconds초', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: '내용을 입력하세요...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: 현재 입력된 텍스트와 시간을 Map에 담아 pop 하세요.
                // 예: Navigator.pop(context, {'content': ..., 'time': ...});
                Navigator.pop(context, {
                  'content': _controller.text,
                  'time': _seconds,
                });
              },
              child: const Text('저장하기'),
            ),
          ],
        ),
      ),
    );
  }
}
