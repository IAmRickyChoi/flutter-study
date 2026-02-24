import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:study_hive_ec/screens/home_screen.dart';
import 'package:study_hive_ec/screens/models/user.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('Users');
  runApp(MaterialApp(home: HomeScreen()));
}
