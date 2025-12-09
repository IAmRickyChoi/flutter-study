import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(home: MyPage()));
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  // 1. 주문서를 담을 변수 준비 (late: 나중에 값 넣겠다는 뜻)
  late Future<String> _myFuture;

  @override
  void initState() {
    super.initState();
    // 2. 앱 켜질 때 딱 한 번만 주문 넣기! (중요)
    _myFuture = getServerData(); 
  }

  // (서버 통신 함수)
  Future<String> getServerData() async {
    await Future.delayed(Duration(seconds: 2));
    return "서버 데이터 도착!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<String>(
          future: _myFuture, // 3. 미리 뽑아둔 주문서 변수 연결
          builder: (context, snapshot) {
            // 위에서 배운 3단계 공식 적용
            if (snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
            if (snapshot.hasError) return Text('에러');
            if (snapshot.hasData) return Text(snapshot.data!);
            return Container();
          },
        ),
      ),
    );
  }
}
