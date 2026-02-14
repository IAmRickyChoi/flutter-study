import 'package:flutter/material.dart';
import 'package:test/screen/home_screen.dart';
import 'package:test/screen/route_one_screen.dart';
import 'package:test/screen/route_two_screen.dart';
import 'package:test/screen/routh_three_screen.dart';


///Imperative vs Declarative
void main(){
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes:{
        ///key - 라우트 이름
        ///value - builder -> 이동하고싶은 라우트
        '/':(BuildContext context) => HomeScreen(),
        '/One':(BuildContext context) => RouteOneScreen(number: 9999),
        '/Two':(BuildContext context) => RouteTwoScreen(),
        '/Three':(BuildContext context) => RouteThreeScreen(),
      }
    )
  );
}