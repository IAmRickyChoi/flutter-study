import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_todo_app/providers/todo_provider.dart';
import 'package:isar_todo_app/screens/home_screen.dart';
import 'package:isar_todo_app/services/isar_service.dart';

// 앱의 진입점(entry point)입니다.
Future<void> main() async {
  // Flutter 엔진과 위젯 트리를 바인딩(연결)합니다.
  // main 함수가 비동기(async)로 실행될 때 반드시 호출해야 합니다.
  WidgetsFlutterBinding.ensureInitialized();

  // IsarService를 생성하고 초기화합니다.
  final isarService = IsarService();
  await isarService.init();

  // 앱 전체에서 Riverpod의 상태를 관리할 수 있도록 ProviderScope로 감싸줍니다.
  runApp(
    ProviderScope(
      overrides: [
        // isarServiceProvider를 override하여 미리 생성된 isarService 인스턴스를 주입합니다.
        isarServiceProvider.overrideWithValue(isarService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isar Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // 디버그 배너를 숨깁니다.
      home: const HomeScreen(), // 앱의 첫 화면으로 HomeScreen을 설정합니다.
    );
  }
}