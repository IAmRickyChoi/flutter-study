import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/features/counter/data/repositories/counter_repository.dart';
import 'package:test/features/test/test_screen.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (context) => CounterRepository(),
      child: const TestScreen(),
    ),
  );
}
