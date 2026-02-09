import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ParentWidget()));

// --- [1. 부모 위젯] ---
class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  State<ParentWidget> createState() {
    print("👨 부모: 1. createState");
    return _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidget> {
  int _dataForChild = 0;
  bool _isChildVisible = true;

  @override
  void initState() {
    super.initState();
    print("👨 부모: 2. initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("👨 부모: 3. didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    print("👨 부모: 4. build (자식을 그릴 준비)");
    return Scaffold(
      appBar: AppBar(title: const Text("Parent-Child Lifecycle")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isChildVisible) 
               ChildWidget(data: _dataForChild)
            else 
               const Text("자식이 없습니다."),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("\n--- 🔄 데이터 변경 버튼 클릭 ---");
                setState(() => _dataForChild++);
              },
              child: const Text("자식에게 새 데이터 전달"),
            ),
            ElevatedButton(
              onPressed: () {
                print("\n--- 🗑️ 자식 제거 버튼 클릭 ---");
                setState(() => _isChildVisible = !_isChildVisible);
              },
              child: const Text("자식 제거/생성"),
            ),
          ],
        ),
      ),
    );
  }
}

// --- [2. 자식 위젯] ---
class ChildWidget extends StatefulWidget {
  final int data;
  const ChildWidget({super.key, required this.data});

  @override
  State<ChildWidget> createState() {
    print("  👶 자식: 1. createState");
    return _ChildWidgetState();
  }
}

class _ChildWidgetState extends State<ChildWidget> {
  @override
  void initState() {
    super.initState();
    print("  👶 자식: 2. initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("  👶 자식: 3. didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant ChildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("  👶 자식: 4. didUpdateWidget (부모로부터 ${oldWidget.data} -> ${widget.data} 받음)");
  }

  @override
  Widget build(BuildContext context) {
    print("  👶 자식: 5. build (그려짐)");
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blue[50],
      child: Text("자식 위젯 데이터: ${widget.data}"),
    );
  }

  @override
  void deactivate() {
    print("  👶 자식: 6. deactivate (트리 이탈)");
    super.deactivate();
  }

  @override
  void dispose() {
    print("  👶 자식: 7. dispose (소멸)");
    super.dispose();
  }
}
