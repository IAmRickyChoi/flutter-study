import 'package:flutter/material.dart';
import 'package:study_flutter/const/colors.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            children: colors.map(
              (e) => Container(
                height:50.0 ,
                width: 50.0,
                color:e)
              ).toList(),
                 ),
        )
      )  
    );
  }
}