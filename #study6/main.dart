import 'dart:async';
import 'dart:isolate';

// [데이터 구조 정의]
sealed class Result<T> {}
class Success<T> extends Result<T> {
  final T value;
  Success(this.value);
}
class Failure<T> extends Result<T> {
  final String errorMessage;
  Failure(this.errorMessage);
}

// ---------------------------------------------------------
// [B] Worker Isolate: 별도의 엔진(스레드)에서 실행
// ---------------------------------------------------------
void worker(SendPort mainSendPort) async {
  // 8: 워커 아이솔레이트 함수가 실제 메모리에 로드되어 실행 시작
  
  // 9: 워커가 사용할 우체통(ReceivePort)을 생성
  final workerReceivePort = ReceivePort();
  
  // 10: [Handshake] 메인에게 워커의 우체통 주소(SendPort)를 전송
  mainSendPort.send(workerReceivePort.sendPort);

  // 11: 메인으로부터 데이터가 오기를 기다리는 대기 상태 진입
  await for (final message in workerReceivePort) {
    // 16: 메인이 보낸 데이터(input)를 수신
    // 24: (반복 후) 메인이 보낸 종료 신호(null)를 수신
    if (message == null) {
      // 25: 워커의 우체통을 닫음
      workerReceivePort.close();
      break;
    }

    final input = message as int;
    
    // 17: 데이터 처리 (음수 체크 및 제곱 연산)
    if (input < 0) {
      // 18-A: 에러 발생 시 Failure 객체 생성 후 메인으로 전송
      mainSendPort.send(Failure<int>("에러 발생: $input은 음수입니다."));
    } else {
      final result = input * input; 
      // 18-B: 성공 시 Success 객체 생성 후 메인으로 전송
      mainSendPort.send(Success<int>(result));
    }
    // 19: 다시 11번 상태로 돌아가 다음 데이터를 기다림
  }
}

// ---------------------------------------------------------
// [A] Main Isolate: 메인 엔진
// ---------------------------------------------------------
class TaskScheduler {
  Stream<Result<int>> process(List<int> inputs) async* {
    // 5: process 함수 진입
    
    // 6: 메인이 워커로부터 메시지를 받을 우체통(ReceivePort) 생성
    final mainReceivePort = ReceivePort();
    
    // 7: 워커 아이솔레이트 생성 및 실행 지시 (worker 함수가 8번으로 이동)
    final isolate = await Isolate.spawn(worker, mainReceivePort.sendPort);

    // 12: 메인 우체통에 들어오는 메시지들을 하나씩 꺼내기 위한 반복자 생성
    final events = StreamIterator(mainReceivePort);

    // 13: 워커가 보낸 핸드셰이크 메시지(워커 주소)가 도착할 때까지 대기
    if (await events.moveNext()) {
      // 14: 워커의 주소(SendPort)를 성공적으로 수신
      final workerSendPort = events.current as SendPort;

      // 15: 입력받은 데이터 리스트(data)를 하나씩 순회 시작
      for (var input in inputs) {
        // 16: 워커에게 데이터 한 개 전송 (워커의 16번으로 이동)
        workerSendPort.send(input); 
        
        // 20: 워커가 연산을 마치고 결과를 보낼 때까지 메인은 여기서 대기
        if (await events.moveNext()) {
          // 21: 워커가 보낸 결과(Success 또는 Failure)를 수신하여 스트림으로 내보냄(yield)
          yield events.current as Result<int>; 
        }
      }
      
      // 23: 모든 리스트 순회가 끝났으므로 워커에게 종료(null) 메시지 전송
      workerSendPort.send(null);
    }

    // 26: 메인 우체통을 닫고 워커 아이솔레이트 자원 완전히 해제
    mainReceivePort.close();
    isolate.kill();
  }
}

void main() async {
  // 1: 프로그램 실행 시작
  print("🚀 일본 기업 코딩 테스트: 병렬 처리 엔진 가동...");

  // 2: TaskScheduler 클래스의 인스턴스(객체) 생성
  final scheduler = TaskScheduler();
  
  // 3: 처리할 정수 데이터 리스트 준비
  final data = [10, 25, -5, 40, 12];

  // 4: scheduler.process(data)를 호출하여 결과 스트림을 구독 시작
  await for (final result in scheduler.process(data)) {
    // 22: yield된 결과를 받아서 화면에 출력 (패턴 매칭)
    switch (result) {
      case Success(value: var val):
        print("✅ 성공: 처리 결과 = $val");
      case Failure(errorMessage: var msg):
        print("❌ 실패: $msg");
    }
  }

  // 27: 모든 작업이 끝나고 마지막 문구 출력
  print("🏁 모든 작업 처리 완료.");
}
