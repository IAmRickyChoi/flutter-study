import 'package:flutter/material.dart';
import 'package:study_flutter/screen/home_screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: HomeScreen(),
      ),
  );
}

