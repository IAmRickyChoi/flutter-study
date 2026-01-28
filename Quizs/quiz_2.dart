// [요구사항 1] Record: (double temp, double humidity, String condition)를 반환하는 
//             'parseWeatherData' 함수를 만드세요.
// [요구사항 2] Extension: Map<String, dynamic>에 .toWeatherRecord() 기능을 추가하여 
//             위의 레코드를 즉시 반환하게 하세요.
// [요구사항 3] Pattern Matching: main에서 레코드를 구조 분해하여 변수에 할당하고 출력하세요.

// TODO 1: Map 확장 메서드 작성
extension WeatherMapExt on Map<String, dynamic> {
  // 힌트: (double, double, String) 타입을 리턴 타입으로 지정하세요.
  (double, double, String) toWeatherRecord() {
    final temp = (this['temp'] as num).toDouble();
    final humidity = (this['humidity'] as num).toDouble();
    final condition = this['condition'] as String;
    return (temp, humidity, condition);
  }
}

// TODO 2: 기상 상태에 따라 이모지를 반환하는 함수 (Switch Expression 활용)
String getWeatherEmoji(String condition) => switch (condition) {
      "Sunny" => "☀️",
      "Cloudy" => "☁️",
      "Rainy" => "🌧️",
      _ => "❓",
    };

void main() {
  // 가상의 API 응답 데이터
  final Map<String, dynamic> apiResponse = {
    "temp": 24.5,
    "humidity": 60.0,
    "condition": "Sunny",
  };

  print("🌡️ 기상 데이터 분석 시작...");

  // TODO 3: 확장 메서드를 호출하여 레코드를 가져오고, '구조 분해'를 통해 변수에 각각 할당하세요.
  // var (temp, hum, cond) = ...
  var (_______, _______, _______) = apiResponse.toWeatherRecord();

  print("현재 온도: $temp°C");
  print("습도: $hum%");
  print("날씨: ${getWeatherEmoji(cond)} ($cond)");
  
  // [보너스 퀴즈] 만약 (double, double, String) 레코드에서 온도(temp)만 필요하다면?
  // var (temp, _, _) = apiResponse.toWeatherRecord(); 
  // 와 같이 와일드카드(_)를 사용할 수 있습니다.
}
