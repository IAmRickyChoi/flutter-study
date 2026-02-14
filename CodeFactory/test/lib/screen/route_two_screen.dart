import 'package:flutter/material.dart';
import 'package:test/layout/dafault_layout.dart';
import 'package:test/screen/routh_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)?.settings.arguments;

    return DefaultLayout(
      title: 'RouteTwoScreen',
      children: [
        Text(argument.toString(), textAlign: TextAlign.center),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/Three', arguments: 9999);
          },
          child: Text('Push Route Three'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return RouteThreeScreen();
                },
              ),
            );
          },
          child: Text('Push replacement'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/Three',
              (route){
                return route.settings.name=='/';
              }
            );
          },
          child: Text('Push Named And Remove Until'),
        ),
      ],
    );
  }
}
