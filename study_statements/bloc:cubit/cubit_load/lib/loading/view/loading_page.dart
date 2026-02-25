import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// 아래에서 만들 배럴 파일과 view 파일을 불러옵니다.
import '../cubit/loading_cubit.dart';
import 'loading_view.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingCubit(),
      child: const LoadingView(), // 진짜 화면으로 토스!
    );
  }
}
