import 'package:flutter/material.dart';
// 방금 만든 BLoC 배럴 파일을 가져옵니다.
import 'counter_bloc/counter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterPage(), // BLoC이 적용된 현관문을 첫 화면으로!
    );
  }
}
