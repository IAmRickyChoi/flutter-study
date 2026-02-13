import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ran_num/component/number_to_image.dart';
import 'package:ran_num/constant/color.dart';
import 'package:ran_num/screen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> numbers = [123, 456, 789];
  int maxNumber = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Header(onPressed: onSettingIconPressed),
              _Body(numbers: numbers),
              _Bottom(onPressed: generateRandomNumber),
            ],
          ),
        ),
      ),
    );
  }

  onSettingIconPressed() async{
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          return SettingScreen(maxNumber: maxNumber,);
        }
      )
    );

    maxNumber=result;
  }

  generateRandomNumber() {
    final rand = Random();

    final Set<int> newNumbers = {};

    while (newNumbers.length < 3) {
      final randomNumber = rand.nextInt(maxNumber);
      newNumbers.add(randomNumber);
    }

    setState(() {
      numbers = newNumbers.toList();
    });
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;
  const _Header({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('랜덤숫자 생성기', style: TextStyle(color: Colors.white, fontSize: 30.0)),
        IconButton(
          color: redColor,
          onPressed: onPressed,
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> numbers;
  const _Body({super.key, required this.numbers});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: numbers
        .map((e) => NumberToImage(number: e))
        .toList(),
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  final VoidCallback onPressed;
  const _Bottom({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: redColor,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text('생성하기'),
    );
  }
}
