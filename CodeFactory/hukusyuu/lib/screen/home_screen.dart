import 'dart:io'; // 수정: File 객체를 사용하기 위해 필요
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? path;

  @override
  // void initState() async { // 틀린 부분: initState에는 async를 붙일 수 없음
  void initState() {
    super.initState();
    _pickImage(); // 수정: 비동기 로직을 별도 함수로 분리하여 호출
  }

  // 이미지 선택을 위한 별도 비동기 함수
  Future<void> _pickImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        path = pickedFile; // 수정: 사진을 선택하면 화면을 다시 그리도록 setState 호출
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 수정: path가 null일 때(사진 선택 전) 에러가 나지 않도록 처리
      body: path == null
          ? const Center(child: Text("이미지를 선택해주세요."))
          : Center(
              // Image.file(path), // 틀린 부분: path는 XFile 타입이며, null일 가능성이 있음
              child: Image.file(
                File(path!.path),
              ), // 수정: XFile을 File 객체로 변환하여 전달
            ),
    );
  }
}
