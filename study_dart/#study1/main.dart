import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// [모델] 데이터 구조 정의
class TodoItem {
  final String id; // 고유 ID (삭제나 수정 시 안전하게 처리하기 위함)
  String text;
  bool isChecked;

  TodoItem({
    required this.id,
    required this.text,
    this.isChecked = false,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 오른쪽 위 'Debug' 띠 제거
      theme: ThemeData(
        useMaterial3: true, // 최신 디자인 적용
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  // 1. [데이터]
  final List<TodoItem> _todoList = [];
  final TextEditingController _textController = TextEditingController();

  // 체크된 항목이 하나라도 있는지 확인 (삭제 버튼 표시용)
  bool get _hasCheckedItems => _todoList.any((item) => item.isChecked);

  // 2. [함수] 리소스 정리 (메모리 누수 방지)
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // 할 일 추가
  void _addTodo() {
    if (_textController.text.trim().isEmpty) return;

    setState(() {
      _todoList.add(TodoItem(
        id: DateTime.now().toString(), // 현재 시간을 ID로 사용
        text: _textController.text,
      ));
      _textController.clear();
    });
  }

  // 체크된 할 일 일괄 삭제
  void _deleteCheckedTodos() {
    setState(() {
      _todoList.removeWhere((item) => item.isChecked);
    });
  }

  // 3. [UI] 화면 구성
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('오늘 할 일', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        backgroundColor: Colors.amber,
        actions: [
          // 체크된 항목이 있을 때만 삭제 버튼 표시
          if (_hasCheckedItems)
            IconButton(
              onPressed: _deleteCheckedTodos,
              icon: const Icon(Icons.delete_outline),
              tooltip: '완료된 항목 삭제',
            ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          // --- [A] 할 일 목록 ---
          Expanded(
            child: _todoList.isEmpty
                ? const Center(
                    child: Text(
                      '할 일이 없습니다.\n아래에서 추가해보세요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _todoList.length,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      final item = _todoList[index];
                      return _buildTodoCard(item, index);
                    },
                  ),
          ),

          // --- [B] 입력창 영역 ---
          _buildInputArea(),
        ],
      ),
    );
  }

  // 리스트 아이템 위젯 분리
  Widget _buildTodoCard(TodoItem item, int index) {
    return Card(
      elevation: 0, // 그림자 제거하여 깔끔하게
      color: item.isChecked ? Colors.grey[100] : Colors.amber[50],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: item.isChecked
            ? BorderSide.none
            : const BorderSide(color: Colors.amber, width: 0.5),
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            item.isChecked = !item.isChecked;
          });
        },
        leading: CircleAvatar(
          backgroundColor: item.isChecked ? Colors.grey : Colors.amber,
          radius: 14,
          child: Text(
            '${index + 1}',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        title: Text(
          item.text,
          style: TextStyle(
            fontSize: 16,
            // 체크 시 회색 + 취소선 효과
            color: item.isChecked ? Colors.grey : Colors.black87,
            decoration: item.isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          value: item.isChecked,
          activeColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onChanged: (value) {
            setState(() {
              item.isChecked = value!;
            });
          },
        ),
      ),
    );
  }

  // 입력창 위젯 분리
  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20), // 하단 여백 확보
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: (_) => _addTodo(),
              decoration: InputDecoration(
                hintText: '무엇을 해야 하나요?',
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _addTodo,
            backgroundColor: Colors.amber,
            elevation: 2,
            mini: true, // 버튼 크기를 살짝 작게
            child: const Icon(Icons.arrow_upward, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
