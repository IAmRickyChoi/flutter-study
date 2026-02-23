import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:study_hive_ec/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('My_Box');
  runApp(MaterialApp(home: HomeScreen()));
}
