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
                      final name = user.name;
                      final age = user.age;
                      // final createdAt = user.createdAt; (현재 Text 위젯에서 사용하지 않아 생략가능)

                      return ListTile(
                        tileColor: Colors.yellow[200],
                        title: Text('name : $name , age : $age'),
                        trailing: IconButton(
                          onPressed: () {
                            // 스트림이 자동으로 감지하므로 삭제만 하면 됩니다.
                            _myBox.deleteAt(index);
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
                  final name = users[index].name;
                  final age = users[index].age;

                  return ListTile(
                    tileColor: Colors.yellow,
                    title: Text('name : $name , age : $age '),
                    trailing: IconButton(
                      onPressed: () {
                        _myBox.deleteAt(index);
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
            // 하단 여백 추가 (BottomSheet가 리스트를 가리지 않도록)
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
              onPressed: onPressedWithoutStream,
              child: Text('no stream'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
              // 🚨 [수정 1] 기존 코드에서는 두 버튼 모두 onPressedWithoutStream을 호출하고 있었습니다.
              // 올바른 함수(onPressedWithStream)로 변경했습니다.
              onPressed: onPressedWithStream,
              child: Text('with stream'),
            ),
          ],
        ),
      ),
    );
  }

  // 🚨 [수정 2] 데이터를 추가할 때 '수동 갱신(setState)'이 필요한지 여부를 알 수 있도록 매개변수(isStream)를 추가했습니다.
  void addUser({required bool isStream}) {
    _myBox.add(
      User(
        name: _nameController.text,
        age: int.tryParse(_ageController.text) ?? 0,
      ),
    );

    // 스트림을 사용하지 않는 모드일 때는 데이터를 추가한 뒤 setState를 호출해 아래쪽 리스트를 수동으로 갱신해 주어야 합니다.
    if (!isStream) {
      setState(() {
        users = _myBox.values.toList();
      });
    }
  }

  void onPressedWithStream() {
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
            // 🚨 [수정 3] 기존 코드에서는 onPressedWithStream 함수를 다시 호출하는 치명적인 버그(무한 팝업)가 있었습니다.
            // addUser를 호출하고 창을 닫도록 수정했습니다.
            TextButton(
              onPressed: () {
                addUser(isStream: true); // 스트림 모드이므로 setState 생략
                Navigator.of(context).pop();
                _nameController.clear();
                _ageController.clear();
              },
              child: Text('with stream add'),
            ),
          ],
        );
      },
    );
  }

  void onPressedWithoutStream() {
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
                // 🚨 [수정 4] 여기서 addUser를 호출할 때 false를 전달하여 내부적으로 setState가 실행되도록 합니다.
                addUser(isStream: false);
                Navigator.of(context).pop();
                _nameController.clear();
                _ageController.clear();
              },
              child: Text('no stream add'),
            ),
          ],
        );
      },
    );
  }
}
