import 'package:flutter/material.dart';
import 'package:study_flutter/const/colors.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...colors.map((e)=>Container(
                    width: 50.0,
                    height:50.0,
                    color:e
                    ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...colors.where((e) => e == Colors.orange)
                  .map((e)=>Container(
                    width: 50.0,
                    height:50.0,
                    color:e
                    ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...colors.map((e)=>Container(
                    width: 50.0,
                    height:50.0,
                    color:e
                    ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...colors.where((e) => e == Colors.green)
                  .map((e)=>Container(
                    width: 50.0,
                    height:50.0,
                    color:e
                    ))
                ],
              ),
            ],
          ),
        )
      )  
    );
  }
}