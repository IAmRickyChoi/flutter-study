import 'package:test/features/counter/bloc/counter_event.dart';
import 'package:test/features/counter/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/features/counter/data/repositories/counter_repository.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final CounterRepository _repository;
  CounterBloc({required repository})
    : _repository = repository,
      super(CounterState(0)) {
    on<CounterIncrementPressed>((event, emit) async {
      final value = await _repository.increment(state.value);
      emit(CounterState(value));
    });
  }
}
