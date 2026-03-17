import 'package:dusty_dust/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Sunflower'),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
