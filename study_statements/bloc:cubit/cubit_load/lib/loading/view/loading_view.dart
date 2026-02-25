import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/loading_cubit.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cubit 비동기 연습')),
      body: Center(
        child: BlocBuilder<LoadingCubit, String>(
          builder: (context, state) {
            if (state == '로딩 중... ⏳') {
              return const CircularProgressIndicator();
            }
            return Text(
              state,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 버튼 클릭 시 큐빗의 함수 실행
          context.read<LoadingCubit>().fetchData();
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}
