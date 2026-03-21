import 'package:dusty_dust/models/stat_model.dart';
import 'package:dusty_dust/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([StatModelSchema], directory: dir.path);

  GetIt.I.registerSingleton<Isar>(isar);

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Sunflower'),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
