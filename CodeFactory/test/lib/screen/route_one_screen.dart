import 'package:flutter/material.dart';
import 'package:test/layout/dafault_layout.dart';
import 'package:test/screen/route_two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  final int number;
  const RouteOneScreen({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: DefaultLayout(
        title: 'Route One Screen',
        children: [
          Text('$number', textAlign: TextAlign.center),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return RouteTwoScreen();
                  },
                  settings: RouteSettings(
                    arguments: 789,
                  )
                ),
              );
            },
            child: Text('Push'),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Pop'),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            child: Text('Maybe Pop'),
          ),
        ],
      ),
    );
  }
}
