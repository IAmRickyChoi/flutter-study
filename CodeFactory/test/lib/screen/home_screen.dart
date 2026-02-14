import 'package:flutter/material.dart';
import 'package:test/layout/dafault_layout.dart';
import 'package:test/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Home Screen',
      children: [
        OutlinedButton(
          onPressed: () async {
            var test = await Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => RouteOneScreen(number: 20),
              ),
              (route) => false,
            );
          },
          child: Text('push'),
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
        ),OutlinedButton(
          onPressed: () {
            print(Navigator.of(context).canPop());
          },
          child: Text('Can Pop'),
        ),

      ],
    );
  }
}
