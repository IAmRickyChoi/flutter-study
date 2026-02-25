import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/counter_bloc.dart';
import 'counter_view.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // 여기서 Cubit 대신 Bloc을 생성해 줍니다!
      create: (context) => CounterBloc(),
      child: const CounterView(), // 진짜 화면으로 토스!
    );
  }
}
