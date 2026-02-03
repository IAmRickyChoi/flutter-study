## 📡 Pure Dart HTTP Networking

전용 라이브러리(Dio)를 사용하기 전, Dart의 핵심 패키지(`http`, `dart:convert`)만을 사용하여 통신의 기초 원리를 학습했습니다.

### 💡 주요 학습 포인트
1. **`Uri.https` 구조화**: URL을 단순 문자열이 아닌 도메인, 경로, 파라미터로 나누어 관리하는 법을 익혔습니다. (Query Parameter는 항상 String으로 전달)
2. **`jsonDecode`의 역할**: 서버에서 받은 문자열(JSON String)을 다트가 이해할 수 있는 데이터 타입(`List`, `Map`)으로 변환하는 필수 과정을 학습했습니다.
3. **데이터 가공 파이프라인**: 
   - `map()`을 통해 원본 데이터를 객체로 우선 변환하여 안정적인 **Dot Syntax(`comment.email`)**를 확보합니다.
   - `where()`를 사용하여 비즈니스 로직에 필요한 데이터만 효율적으로 추출합니다.



### 🧪 실습 시나리오
- **목표**: 특정 포스트의 댓글 중 `.biz` 도메인을 사용하는 작성자 필터링
- **도구**: `package:http`, `dart:convert`
