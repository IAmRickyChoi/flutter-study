import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/counter_bloc.dart';
import '../bloc/counter_event.dart'; // 주문서 파일도 가져와야 던질 수 있습니다!

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BLoC 카운터 앱')),
      body: Center(
        // 상태(int)를 바라보고 있다가 바뀌면 다시 그립니다.
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
            return Text(
              '현재 숫자: $state',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      // 더하기, 빼기 버튼 2개를 세로로 배치합니다.
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // [결정적 차이!] 큐빗: 함수 실행 -> 블록: 주문서(이벤트) 추가(add)
              context.read<CounterBloc>().add(CounterIncrementPressed());
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10), // 버튼 사이 간격
          FloatingActionButton(
            onPressed: () {
              // 빼기 주문서 추가!
              context.read<CounterBloc>().add(CounterDecrementPressed());
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
