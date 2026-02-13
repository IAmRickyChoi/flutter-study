import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(home: MyWidget())
  );
}




class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height:200,
          width: 200,
          color: Colors.red,
          child : Align(
            alignment: Alignment(0,-0.5),
            child: Container(
              height: 50,
              width: 50,
              color: Colors.blue,
            ),
          )
        ),
      ),
    );
  }
}