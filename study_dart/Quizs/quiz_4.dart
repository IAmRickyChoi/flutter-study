import 'dart:async';
import 'dart:isolate';

// 1. Result 패턴을 위한 Sealed Class를 정의하세요.
// TODO: 여기에 Result, Success, Failure 클래스를 작성하세요.


// 2. Isolate에서 실행될 무거운 작업(Worker)을 정의하세요.
// TODO: SendPort를 통해 메인 스레드와 통신하며 데이터를 처리하는 로직을 작성하세요.
void worker(SendPort mainSendPort) async {
  // 여기에 ReceivePort 생성 및 메인 스레드와의 핸드셰이크 로직을 작성하세요.
}

// 3. 작업을 관리하고 스트림을 반환하는 스케줄러를 정의하세요.
class TaskScheduler {
  // TODO: Isolate을 생성하고 작업을 배분한 뒤 결과를 스트림으로 내보내세요.
  Stream<Result<int>> process(List<int> inputs) async* {
    // 여기에 Isolate 생성 및 데이터 전송/수신 로직을 작성하세요.
  }
}

void main() async {
  print("🚀 일본 기업 코딩 테스트: 병렬 처리 엔진 가동...");

  final scheduler = TaskScheduler();
  final data = [10, 25, -5, 40, 12]; // -5는 에러를 유도하는 데이터로 활용해 보세요.

  // 4. 결과를 출력하세요.
  // TODO: scheduler.process(data)를 구독하고 패턴 매칭으로 결과를 출력하세요.
  
  print("🏁 모든 작업 처리 완료.");
}
