import 'dart:developer';

import 'package:flutter/material.dart';

class StateFul extends StatefulWidget {
  const StateFul({super.key});

  @override
  State<StateFul> createState() => _StateFullState();
}

class _StateFullState extends State<StateFul> {

Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:(){

                if(color == Colors.blue){
                  color = Colors.red;
                }else{
                  color = Colors.blue;
                }
                
                log("print $color");

                setState(() {
                  
                });
              },
              child: Text("test"),
              ),
            const SizedBox(
              height: 32.0,
              ),
            Container(
              width: 50.0,
              height: 50.0,
              color: color,
            )
          ],
        ),
      ),
    );
  }
}