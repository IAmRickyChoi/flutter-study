import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/features/counter/bloc/counter_bloc.dart';
import 'package:test/features/counter/bloc/counter_event.dart';
import 'package:test/features/counter/bloc/counter_state.dart';
import 'package:test/features/counter/data/repositories/counter_repository.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CounterBloc(repository: context.read<CounterRepository>()),
      child: CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) => Center(child: Text('${state.value}')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              context.read<CounterBloc>().add(CounterIncrementPressed()),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
