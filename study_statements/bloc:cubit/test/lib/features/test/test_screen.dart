import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/features/test/test_bloc.dart';
import 'package:test/features/test/test_event.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: BlocProvider(
            create: (context) => TestBloc(),
            child: _Screen(),
          ),
        ),
      ),
    );
  }
}

class _Screen extends StatelessWidget {
  const _Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<TestBloc, int>(
          builder: (context, state) {
            return Text(state.toString());
          },
        ),
        OutlinedButton(
          onPressed: () {
            context.read<TestBloc>().add(Increment());
          },
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
