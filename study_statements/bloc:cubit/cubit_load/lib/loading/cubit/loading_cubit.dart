import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingCubit extends Cubit<String> {
  LoadingCubit() : super('버튼을 눌러주세요 👆');

  Future<void> fetchData() async {
    emit('로딩 중... ⏳');
    await Future.delayed(const Duration(seconds: 2));
    emit('데이터 가져오기 성공! 🎉');
  }
}
