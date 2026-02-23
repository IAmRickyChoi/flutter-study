import 'dart:convert';

// ==========================================
// 1단계: 기본 & 중첩 객체 (Nested Objects)
// ==========================================
class Contact {
  final String email;
  final String phone;
  Contact({required this.email, required this.phone});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      email: json["email"] ?? "no-email",
      phone: json["phone"] ?? "no-phone",
    );
  }
}

class Manager {
  final String name;
  final Contact contact;
  Manager({required this.name, required this.contact});

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      name: json["name"],
      contact: Contact.fromJson(json["contact"] ?? {}),
    );
  }
}

// ==========================================
// 2단계: 방어적 코딩 (Defensive Coding)
// 데이터 타입이 섞여 있거나 null일 때 앱을 보호하는 기술
// ==========================================
class Weather {
  final String day;
  final double temp;
  Weather({required this.day, required this.temp});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      day: json["day"] ?? "Unknown",
      // 핵심: toString() 후 tryParse를 통해 어떤 타입이든 double로 안전하게 변환
      temp: double.tryParse(json["temp"].toString()) ?? 0.0,
    );
  }
}

// ==========================================
// 3단계: 동적 키 처리 (Dynamic Keys / Entries Mapping)
// Key 자체가 데이터(날짜, 팀이름 등)인 경우를 처리하는 기술
// ==========================================
class Dish {
  final String name;
  final int kcal;
  Dish({required this.name, required this.kcal});

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      name: json["name"],
      kcal: int.tryParse(json["kcal"].toString()) ?? 0,
    );
  }
}

class DailyMenu {
  final String date; // JSON의 Key에서 추출할 데이터
  final List<Dish> dishes; // JSON의 Value에서 추출할 리스트

  DailyMenu({required this.date, required this.dishes});
}

class SchoolMenu {
  final String schoolName;
  final List<DailyMenu> weeklyMenu;

  SchoolMenu({required this.schoolName, required this.weeklyMenu});

  factory SchoolMenu.fromJson(Map<String, dynamic> json) {
    // weeklyMenu가 { "2024-05-01": [...] } 형태의 Map임
    var rawMap = json["weeklyMenu"] as Map<String, dynamic>;

    return SchoolMenu(
      schoolName: json["schoolName"],
      // 💡 핵심: .entries.map을 사용하여 Key를 date로, Value를 List<Dish>로 변환
      weeklyMenu: rawMap.entries.map((entry) {
        return DailyMenu(
          date: entry.key,
          dishes: (entry.value as List).map((d) => Dish.fromJson(d)).toList(),
        );
      }).toList(),
    );
  }
}

void main() {
  print('🚀 Dart JSON Parsing Mastery Practice\n');

  // 실습 데이터: 동적 키와 중첩 리스트가 포함된 복잡한 구조
  Map<String, dynamic> schoolJson = {
    "schoolName": "플러터 고등학교",
    "weeklyMenu": {
      "2024-05-01": [
        {"name": "미역국", "kcal": 150},
        {"name": "불고기", "kcal": "300"} // 문자열 숫자 혼합
      ],
      "2024-05-02": [
        {"name": "김치찌개", "kcal": 200},
        {"name": "계란말이", "kcal": null} // null 포함
      ]
    }
  };

  // 파싱 실행
  SchoolMenu mySchool = SchoolMenu.fromJson(schoolJson);

  print('🏫 학교: ${mySchool.schoolName}');
  for (var daily in mySchool.weeklyMenu) {
    print('\n📅 날짜: ${daily.date}');
    for (var dish in daily.dishes) {
      print('  - ${dish.name}: ${dish.kcal}kcal');
    }
  }
  
  print('\n✅ 모든 파싱 테스트 완료!');
}
