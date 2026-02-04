import 'dart:convert';
import 'package:http/http.dart' as http;

// ==========================================
// 1. 하위 모델: ArticleMeta (중첩 객체 & 방어적 코딩)
// ==========================================
class ArticleMeta {
  final String author;
  final int hits;

  ArticleMeta({required this.author, required this.hits});

  // [받기] Map -> Object
  factory ArticleMeta.fromJson(Map<String, dynamic> json) {
    return ArticleMeta(
      author: json["author"] ?? "Anonymous",
      // 숫자가 문자열로 오거나 null일 경우를 대비한 철벽 방어
      hits: int.tryParse(json["hits"].toString()) ?? 0,
    );
  }

  // [보내기] Object -> Map
  Map<String, dynamic> toJson() {
    return {
      "author": author,
      "hits": hits,
    };
  }
}

// ==========================================
// 2. 중간 모델: Article (Null 허용 객체 포함)
// ==========================================
class Article {
  final String id;
  final String title;
  final ArticleMeta? meta; // null이 올 수 있음을 명시

  Article({required this.id, required this.title, this.meta});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json["id"] ?? "No-ID",
      title: json["title"] ?? "Untitled",
      // meta가 null이면 null을, 데이터가 있으면 객체를 생성
      meta: json["meta"] != null ? ArticleMeta.fromJson(json["meta"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "meta": meta?.toJson(), // meta가 null이면 자동으로 null이 들어감
    };
  }
}

// ==========================================
// 3. 최상위 모델: NewsResponse (복합 구조 & 페이지네이션)
// ==========================================
class NewsResponse {
  final int currentPage;
  final bool hasNext;
  final List<Article> articles;

  NewsResponse({
    required this.currentPage,
    required this.hasNext,
    required this.articles,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    // 주머니(Nested Map) 추출 및 null 방어
    var info = json["info"] as Map<String, dynamic>? ?? {};
    var content = json["content"] as Map<String, dynamic>? ?? {};

    return NewsResponse(
      currentPage: info["currentPage"] ?? 1,
      hasNext: info["hasNext"] ?? false,
      // 리스트 파싱의 정석: map().toList()
      articles: (content["articles"] as List? ?? [])
          .map((e) => Article.fromJson(e))
          .toList(),
    );
  }
}

// ==========================================
// 4. 실전 HTTP 서비스 함수 (GET & POST)
// ==========================================

// [GET] 데이터를 가져와서 객체로 변환
Future<NewsResponse> fetchNews() async {
  // 실제 사용 예시: final response = await http.get(Uri.parse('URL'));
  
  // 시뮬레이션을 위한 가상의 복합 JSON 데이터
  const mockJson = '''
  {
    "info": { "currentPage": 1, "hasNext": true },
    "content": {
      "articles": [
        { "id": "A-01", "title": "Dart Mastery", "meta": { "author": "User", "hits": 100 } },
        { "id": "A-02", "title": "JSON Deep Dive", "meta": null }
      ]
    }
  }
  ''';

  final data = jsonDecode(mockJson);
  return NewsResponse.fromJson(data);
}

// [POST] 객체를 JSON으로 변환하여 전송
Future<void> sendArticle(Article article) async {
  print('\n📡 서버로 데이터 전송 중...');
  
  // 💡 핵심: toJson()으로 Map을 만들고, jsonEncode()로 문자열화함
  final String jsonBody = jsonEncode(article.toJson());
  
  print('📦 전송될 JSON 데이터: $jsonBody');
  // 실제 전송 예시: await http.post(url, body: jsonBody, headers: {...});
  print('✅ 전송 완료!');
}

// ==========================================
// 5. 실행부
// ==========================================
void main() async {
  print('🚀 --- JSON Mastery 실전 테스트 ---');

  // 1. GET 테스트
  NewsResponse news = await fetchNews();
  print('📄 현재 페이지: ${news.currentPage}');
  print('📰 첫 번째 기사: ${news.articles.first.title}');

  // 2. POST 테스트
  Article myNewArticle = Article(
    id: "NEW-99",
    title: "나도 이제 JSON 전문가",
    meta: ArticleMeta(author: "나", hits: 0),
  );
  
  await sendArticle(myNewArticle);
}
