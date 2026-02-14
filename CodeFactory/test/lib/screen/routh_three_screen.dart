import 'package:flutter/material.dart';
import 'package:test/layout/dafault_layout.dart';

class RouteThreeScreen extends StatelessWidget {
  const RouteThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return DefaultLayout(
      title: 'Three',
      children: [
        OutlinedButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          child: Text('Pop')
        )
      ],
    );
  }
}