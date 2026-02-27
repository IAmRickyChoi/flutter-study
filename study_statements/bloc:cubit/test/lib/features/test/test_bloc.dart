import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/features/test/test_event.dart';
import 'package:test/features/test/test_state.dart';

class TestBloc extends Bloc<TestEvent, int> {
  TestBloc() : super(0) {
    on<Increment>((event, emit) {
      emit(state + 1);
    });
  }
}
