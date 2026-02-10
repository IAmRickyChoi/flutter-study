import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _Top(selectedDate: selectedDate, onPressed: onHeartPressed),
              _Bottom(),
            ],
          ),
        ),
      ),
    );
  }

  void onHeartPressed() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              maximumDate: DateTime.now(),
              initialDateTime: selectedDate,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  selectedDate = date;
                });
              },
              dateOrder: DatePickerDateOrder.ymd,
            ),
          ),
        );
      },
    );
  }
}

class _Top extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback? onPressed;
  const _Top({required this.selectedDate, required this.onPressed, super.key});

  ///이건 왜 빌드 안에서 정의못해?

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Container(
        child: Column(
          children: [
            Text('U&I', style: textTheme.displayLarge),
            Text('우리 처음 만난날', style: textTheme.displayMedium),
            Text(
              '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
              style: textTheme.bodyLarge,
            ),
            IconButton(
              iconSize: 60.0,
              color: Colors.red,
              onPressed: onPressed,
              icon: Icon(Icons.favorite),
            ),
            Text(
              'D + ${now.difference(selectedDate).inDays + 1}',
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(child: Image.asset('asset/img/middle_image.png')),
    );
  }
}
