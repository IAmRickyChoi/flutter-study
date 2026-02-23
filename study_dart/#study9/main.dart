import 'dart:convert';
import 'package:http/http.dart' as http;

/// 1. 데이터 모델 클래스 (Comment)
/// JSON의 키와 클래스의 필드를 1:1로 매핑하고 factory 생성자를 통해 객체화합니다.
class Comment {
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      body: json["body"],
    );
  }

  @override
  String toString() => 'Comment(id: $id, email: $email)';
}

void main() async {
  // 2. Uri.https를 이용한 구조적인 URL 생성
  // 주의: Query Parameter의 값(value)은 반드시 'String' 타입이어야 함.
  final url = Uri.https('jsonplaceholder.typicode.com', '/comments', {
    'postId': '1', 
  });

  print('🚀 요청 시작: $url');

  try {
    // 3. HTTP GET 요청
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // 4. JSON 디코딩 (String -> List/Map)
      // Pure Dart에서는 jsonDecode를 직접 호출해야 함.
      final List<dynamic> rawList = jsonDecode(response.body);

      // 5. 고오급 체이닝 로직 (Map -> Filter -> List)
      // - map: Map 데이터를 Comment 객체로 변환 (마침표 문법 사용 가능)
      // - where: 특정 조건(.biz 이메일)에 맞는 데이터만 필터링
      final List<Comment> bizComments = rawList
          .map((item) => Comment.fromJson(item))
          .where((comment) => comment.email.endsWith('.biz'))
          .toList();

      // 6. 결과 출력
      print('✅ 필터링된 결과 (${bizComments.length}건):');
      for (var comment in bizComments) {
        print('- [${comment.name}] : ${comment.email}');
      }
      
    } else {
      print('❌ 서버 응답 에러: ${response.statusCode}');
    }
  } catch (e) {
    // 7. 네트워크 예외 처리
    print('❌ 네트워크 에러 발생: $e');
  }

  print('\n🏁 모든 작업 완료');
}
