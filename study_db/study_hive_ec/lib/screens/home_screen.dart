import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:study_hive_ec/screens/models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _myBox = Hive.box<User>('Users');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  List<User> users = [];

  @override
  void initState() {
    super.initState();
    users = _myBox.values.toList();
    print(users);
  }

  // 💡 [개선 2] 컨트롤러 메모리 해제
  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              '--- With Stream ---',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder(
                stream: _myBox.watch(),
                builder: (context, snapshot) {
                  final streamUsers = _myBox.values.toList();

                  if (streamUsers.isEmpty) {
                    return Center(child: Text('데이터가 없습니다.'));
                  }

                  return ListView.builder(
                    itemCount: streamUsers.length,
                    itemBuilder: (context, index) {
                      final user = streamUsers[index];
                      return ListTile(
                        tileColor: Colors.yellow[200],
                        title: Text('name : ${user.name} , age : ${user.age}'),
                        trailing: IconButton(
                          onPressed: () {
                            // 💡 [개선 3] 인덱스 대신 해당 데이터의 고유 Key를 가져와서 안전하게 삭제
                            final key = _myBox.keyAt(index);
                            _myBox.delete(key);
                          },
                          icon: Icon(Icons.delete, color: Colors.blue[300]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Divider(thickness: 2, color: Colors.black),
            Text(
              '--- Without Stream ---',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    tileColor: Colors.yellow,
                    title: Text('name : ${user.name} , age : ${user.age}'),
                    trailing: IconButton(
                      onPressed: () {
                        // 💡 [개선 3] 안전한 삭제 방식 적용
                        final key = _myBox.keyAt(index);
                        _myBox.delete(key);
                        setState(() {
                          users = _myBox.values.toList();
                        });
                      },
                      icon: Icon(Icons.delete, color: Colors.blue[300]),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
              // 하나의 다이얼로그 함수에 isStream 값만 다르게 넘겨줍니다.
              onPressed: () => _showAddDialog(isStream: false),
              child: Text('no stream'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
              onPressed: () => _showAddDialog(isStream: true),
              child: Text('with stream'),
            ),
          ],
        ),
      ),
    );
  }

  void addUser({required bool isStream}) {
    _myBox.add(
      User(
        name: _nameController.text,
        age: int.tryParse(_ageController.text) ?? 0,
      ),
    );

    if (!isStream) {
      setState(() {
        users = _myBox.values.toList();
      });
    }
  }

  // 💡 [개선 1] 두 개로 나뉘어 있던 다이얼로그 함수를 하나로 깔끔하게 통합!
  void _showAddDialog({required bool isStream}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: '이름'),
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: '나이'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _nameController.clear();
                _ageController.clear();
                Navigator.of(context).pop();
              },
              child: Text('cancel'),
            ),
            TextButton(
              onPressed: () {
                addUser(isStream: isStream);
                Navigator.of(context).pop();
                _nameController.clear();
                _ageController.clear();
              },
              // isStream 여부에 따라 버튼 텍스트도 다르게 보여줍니다.
              child: Text(isStream ? 'with stream add' : 'no stream add'),
            ),
          ],
        );
      },
    );
  }
}
