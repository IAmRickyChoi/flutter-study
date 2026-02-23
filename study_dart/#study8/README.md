# 🚀 Flutter & Dart JSON Modeling Mastery

이 저장소는 Dart와 Flutter에서 서버 데이터를 다루기 위한 **JSON 모델링의 핵심 패턴**을 학습하고 정리한 공간입니다. 기초적인 1:1 매핑부터 실무 수준의 복잡한 중첩 구조, 데이터 클리닝까지의 과정이 담겨 있습니다.

## 📌 핵심 학습 내용

### 1. JSON 모델링의 정석 (Factory Pattern)
- JSON(`Map<String, dynamic>`) 데이터를 Dart 객체로 변환하는 가장 안전한 방법인 `factory Class.fromJson` 패턴을 익혔습니다.

### 2. 리스트 데이터 처리 (`map().toList()`)
- 서버에서 오는 리스트 형태의 데이터를 객체 리스트로 변환하는 필수 공식을 학습했습니다.
- **`.map()`**: 각 요소를 순회하며 변환 (심부름 역할)
- **`.toList()`**: 변환된 요소들을 하나의 리스트로 확정 (포장 역할)

### 3. 중첩 객체 및 래퍼 구조 (Nested & Wrapper)
- 객체 안에 또 다른 객체나 리스트가 있는 복잡한 JSON 구조를 클래스 분리 및 연결을 통해 체계적으로 관리하는 방법을 익혔습니다.

### 4. 데이터 클리닝 (Data Cleaning & Safety)
- **형 변환**: 문자열로 들어온 숫자(`"100"`)를 `int.parse()`로 변환 처리.
- **Null Safety**: `??` 연산자를 활용하여 데이터가 누락되었을 때 기본값(Default Value)을 설정하는 방어적 코딩을 적용했습니다.

---

## 🛠 주요 코드 패턴

### 💡 객체 리스트 변환 패턴
```dart
// json['data']가 리스트인 경우의 정석 처리
data: (json['data'] as List).map((item) => Model.fromJson(item)).toList()
