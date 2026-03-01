import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/features/test/test_event.dart';
import 'package:test/features/test/test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestState(value: 0)) {
    on<Increment>((event, emit) {
      emit(TestState(value: state.value + 1));
    });
    on<decrement>((event, emit) {
      emit(TestState(value: state.value - 1));
    });
  }
}
