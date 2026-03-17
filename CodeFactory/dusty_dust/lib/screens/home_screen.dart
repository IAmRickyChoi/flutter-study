import 'package:dusty_dust/components/category_stat.dart';
import 'package:dusty_dust/components/main_stat.dart';
import 'package:dusty_dust/const/color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(children: [MainStat(), CategoryStat()]),
      ),
    );
  }
}
