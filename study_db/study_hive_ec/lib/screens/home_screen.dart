import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _myBox = Hive.box('My_Box');
  final TextEditingController _textController = TextEditingController();

  List todos = [];

  @override
  void initState() {
    super.initState();
    todos = _myBox.get('My_List') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  todos.removeAt(index);
                });
                _myBox.put('My_Box', todos);
              },
              icon: Icon(Icons.delete),
            ),
          );
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
                      content: TextFormField(controller: _textController),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _textController.clear();
                          },
                          child: Text('cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              todos.add(_textController.text);
                            });
                            _myBox.put('My_List', todos);
                            Navigator.of(context).pop();
                            _textController.clear();
                          },
                          child: Text('add'),
                        ),
                      ],
                    );
                  },
                );
                print(_textController);
              },
              child: Text('put'),
            ),
            OutlinedButton(onPressed: () {}, child: Text('read')),
            OutlinedButton(onPressed: () {}, child: Text('delete')),
          ],
        ),
      ),
    );
  }
}
