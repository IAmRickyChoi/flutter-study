import 'package:flutter/material.dart';
import 'package:habit_tracker/views/home_screen.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox("Habit_Database");

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(primarySwatch: Colors.red),
    ),
  );
}
