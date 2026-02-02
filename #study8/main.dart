import 'dart:convert';

// ==========================================
// 1. 중첩 객체 & 리스트 패턴 (Post & Author)
// ==========================================
class Author {
  final String username;
  final bool isPremium;

  Author({required this.username, required this.isPremium});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      username: json["username"] ?? "Unknown",
      isPremium: json["isPremium"] ?? false,
    );
  }

  @override
  String toString() => 'Author: $username (Premium: $isPremium)';
}

class Post {
  final String id;
  final String content;
  final Author author;
  final List<String> hashtags;

  Post({
    required this.id,
    required this.content,
    required this.author,
    required this.hashtags,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"].toString(),
      content: json["content"] ?? "",
      author: Author.fromJson(json["author"]),
      // 단순 문자열 리스트 처리 패턴
      hashtags: List<String>.from(json["hashtags"] ?? []),
    );
  }

  @override
  String toString() => 'Post[$id]: $content \n $author \n Tags: $hashtags';
}

// ==========================================
// 2. 서버 응답 래퍼 패턴 (ApiResponse & Office)
// ==========================================
class Office {
  final String roomName;
  final bool isAvailable;

  Office({required this.roomName, required this.isAvailable});

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      roomName: json["roomName"] ?? "No Name",
      isAvailable: json["isAvailable"] ?? false,
    );
  }
}

class ApiResponse {
  final String status;
  final String message;
  final List<Office> data;

  ApiResponse({required this.status, required this.message, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var list = json["data"] as List;
    return ApiResponse(
      status: json["status"] ?? "error",
      message: json["message"] ?? "",
      // 객체 리스트 변환 패턴
      data: list.map((item) => Office.fromJson(item)).toList(),
    );
  }
}

// ==========================================
// 3. 데이터 클리닝 패턴 (Product & PriceInfo)
// ==========================================
class PriceInfo {
  final int amount;
  final String currency;

  PriceInfo({required this.amount, required this.currency});

  factory PriceInfo.fromJson(Map<String, dynamic> json) {
    return PriceInfo(
      amount: json["amount"] ?? 0,
      currency: json["currency"] ?? "KRW",
    );
  }
}

class Product {
  final String prodName;
  final int price;
  final double discount;

  Product({required this.prodName, required this.price, required this.discount});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      prodName: json["prodName"] ?? "이름 없음",
      // 문자열로 온 숫자를 int로 변환하는 패턴
      price: int.parse(json["price"].toString()),
      // Null 방어 패턴
      discount: (json["discount"] ?? 0.0).toDouble(),
    );
  }

  @override
  String toString() => '상품: $prodName | 가격: $price | 할인: $discount';
}

// ==========================================
// 메인 실행부: 테스트 데이터 및 실행 로직
// ==========================================
void main() {
  print('--- 1. 중첩 객체 테스트 ---');
  Map<String, dynamic> postJson = {
    "id": "post-123",
    "content": "Dart JSON 공부 중!",
    "author": {"username": "flutter_user", "isPremium": true},
    "hashtags": ["dart", "json", "study"]
  };
  final post = Post.fromJson(postJson);
  print(post);

  print('\n--- 2. 리스트 응답 테스트 ---');
  Map<String, dynamic> apiJson = {
    "status": "success",
    "message": "로드 완료",
    "data": [
      {"roomName": "서울역점", "isAvailable": true},
      {"roomName": "강남점", "isAvailable": false}
    ]
  };
  final response = ApiResponse.fromJson(apiJson);
  print('상태: ${response.status}, 데이터 개수: ${response.data.length}');

  print('\n--- 3. 데이터 클리닝 테스트 ---');
  List<dynamic> productsRaw = [
    {"prodName": "키보드", "price": "150000", "discount": 0.1},
    {"prodName": "마우스", "price": "45000", "discount": null}
  ];
  List<Product> products = productsRaw.map((e) => Product.fromJson(e)).toList();
  products.forEach(print);
}
