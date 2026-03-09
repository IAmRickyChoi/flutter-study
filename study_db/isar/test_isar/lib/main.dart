import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==========================================
// 1. 상태 관리자 (시간이 걸리는 주방장)
// ==========================================
// 이제 시간이 걸리는 작업을 하므로 'AsyncNotifier'를 씁니다!
class AsyncCounterNotifier extends AsyncNotifier<int> {
  // 앱 켜고 처음 화면 볼 때 실행됨.
  // 인터넷에서 초기 숫자를 가져오느라 2초가 걸린다고 가정(Future.delayed)
  @override
  Future<int> build() async {
    await Future.delayed(const Duration(seconds: 2));
    return 0; // 2초 뒤에 0을 줍니다.
  }

  // 버튼 누를 때 실행할 함수
  Future<void> increment() async {
    // 1. "지금부터 요리 시작합니다! 기다려주세요!" (로딩 상태로 변경)
    state = const AsyncLoading();

    // 2. 인터넷에 숫자를 저장하느라 2초가 걸린다고 흉내 내기
    await Future.delayed(const Duration(seconds: 2));

    // 3. 기존 숫자(state.value)에 1을 더합니다. (값이 없으면 0)
    int currentCount = state.value ?? 0;

    // 4. "요리 완성! 예쁘게 포장해서 줍니다!" (AsyncData 상자에 담아서 전달)
    state = AsyncData(currentCount + 1);
  }
}

// 호출벨 (Provider)
final asyncCounterProvider = AsyncNotifierProvider<AsyncCounterNotifier, int>(
  () {
    return AsyncCounterNotifier();
  },
);

// ==========================================
// 2. 화면 (UI)
// ==========================================
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AsyncCounterScreen());
  }
}

class AsyncCounterScreen extends ConsumerWidget {
  const AsyncCounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. 호출벨을 쳐다봅니다.
    // 이번엔 시간이 걸리기 때문에 일반 숫자(int)가 아니라 '택배 상자(AsyncValue)'가 옵니다.
    final asyncState = ref.watch(asyncCounterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('로딩이 있는 비동기 카운터')),
      body: Center(
        // 2. 택배 상자의 상태에 따라 화면을 다르게 보여줍니다! (when 사용)
        child: asyncState.when(
          // 배송 완료! 내용물을 뜯어서(count) 보여줌
          data: (count) => Text(
            '현재 숫자: $count',
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          // 배송 중... (로딩 빙글빙글)
          loading: () => const CircularProgressIndicator(),
          // 배송 사고 (에러 텍스트)
          error: (error, stack) => Text('에러 발생: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 버튼 누르면 숫자 올려달라고 주문!
          ref.read(asyncCounterProvider.notifier).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
