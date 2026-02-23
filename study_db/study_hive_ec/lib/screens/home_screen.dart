import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _myBox = Hive.box('My_Box');

  _putData() {
    _myBox.put(1, 'test2');
  }

  _readData() {
    print(_myBox.get(1));
  }

  _deleteData() {
    _myBox.delete(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return;
        },
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('add'),
                      content: AboutListTile(),
                    );
                  },
                );
              },
              child: Text('put'),
            ),
            OutlinedButton(
              onPressed: () {
                _readData();
              },
              child: Text('read'),
            ),
            OutlinedButton(
              onPressed: () {
                _deleteData();
              },
              child: Text('delete'),
            ),
          ],
        ),
      ),
    );
  }
}
