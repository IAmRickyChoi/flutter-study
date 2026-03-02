import 'package:flutter/material.dart';
import 'package:scroll_views/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
    ),
  );
}
