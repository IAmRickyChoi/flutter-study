import 'package:http/http.dart' as http;
import 'dart:convert';

// 1. 전송할 데이터 모델 (앞서 배운 내용 복습!)
class Post {
  final String title;
  final String body;
  final int userId;

  Post({required this.title, required this.body, required this.userId});

  // 서버로 보내기 위해 Map으로 변환
  Map<String, dynamic> toJson() => {
    'title': title,
    'body': body,
    'userId': userId,
  };
}

class ApiService {
  Map<String, String> get _headers => {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer my-secret-token-123',
  };

  final String baseUrl = 'jsonplaceholder.typicode.com';

  // [GET] 목록 조회
  Future<void> fetchPostsByUserId(int userId) async {
    final url = Uri.https(baseUrl, '/posts', {'userId': userId.toString()});
    try {
      final response = await http.get(url, headers: _headers);
      if (response.statusCode == 200) {
        print('✅ 조회 성공: ${jsonDecode(response.body).length}개의 글 발견');
      }
    } catch (e) { print('🚨 GET 에러: $e'); }
  }

  // [POST] 데이터 생성 💡 (새로 추가된 기능!)
  Future<void> createPost(Post post) async {
    final url = Uri.https(baseUrl, '/posts');

    try {
      final response = await http.post(
        url,
        headers: _headers,
        // 💡 핵심: 객체를 toJson()으로 Map을 만들고, jsonEncode로 문자열화!
        body: jsonEncode(post.toJson()), 
      );

      if (response.statusCode == 201) {
        print('✅ 생성 성공! 서버 응답: ${response.body}');
      } else {
        print('❌ 생성 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('🚨 POST 에러: $e');
    }
  }

  // [DELETE] 데이터 삭제
  Future<void> deletePost(int postId) async {
    final url = Uri.parse('https://$baseUrl/posts/$postId');
    try {
      final response = await http.delete(url, headers: _headers);
      if (response.statusCode == 200) print('✅ $postId번 삭제 성공!');
    } catch (e) { print('🚨 DELETE 에러: $e'); }
  }
}

void main() async {
  final apiService = ApiService();

  // 1. 새로운 포스트 객체 생성
  final newPost = Post(
    title: '나의 첫 POST 요청',
    body: 'http 패키지 마스터 완료!',
    userId: 1,
  );

  print('📡 서버 통신 시작...');
  
  // 2. POST 테스트
  await apiService.createPost(newPost);
  
  // 3. DELETE 테스트
  await apiService.deletePost(1);
}
