import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<int>(
        future: getNumber(), 
        builder: (BuildContext context,AsyncSnapshot<int> snapshot){
          ///error
          if(snapshot.hasError){
            //final error = snapshot.error
          }
          if(snapshot.hasData){
            final data=snapshot.data;
            return Center(
              child: Text(data.toString()),
            );
          }
          return Center(
            child: Text("no text"),
          );
        },
      ),
    );
  }

  Future<int> getNumber()async{
    await Future.delayed(Duration(seconds: 2));
    final random = Random();

    return random.nextInt(100);
  }

}