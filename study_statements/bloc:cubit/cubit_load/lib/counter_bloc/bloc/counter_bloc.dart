import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_event.dart'; // 주문서 파일을 가져옵니다.

// Bloc<이벤트 타입, 상태 타입(숫자)>
class CounterBloc extends Bloc<CounterEvent, int> {
  // 초기 상태는 0으로 세팅!
  CounterBloc() : super(0) {
    // [핵심] 더하기 주문서가 들어오면? -> 현재 상태에 +1 해서 방출(emit)
    on<CounterIncrementPressed>((event, emit) {
      emit(state + 1);
    });

    // [핵심] 빼기 주문서가 들어오면? -> 현재 상태에 -1 해서 방출(emit)
    on<CounterDecrementPressed>((event, emit) {
      emit(state - 1);
    });
  }
}
