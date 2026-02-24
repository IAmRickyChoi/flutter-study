import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:todo_app/view/home_screen.dart';

void main() async {
  await Hive.initFlutter();

  var test = await Hive.openBox("My_Box");

  print("print");
  print(test.values);

  runApp(
    MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    ),
  );
}
