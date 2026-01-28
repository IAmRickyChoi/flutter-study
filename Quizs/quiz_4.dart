import 'dart:async';
import 'dart:isolate';

// [요구사항 1] Result 패턴 정의 (Sealed Class)
sealed class Result<T> {}
class Success<T> extends Result<T> { final T data; Success(this.data); }
class Failure<T> extends Result<T> { final String error; Failure(this.error); }

// 처리할 작업 정의
class WorkTask {
  final int id;
  final int input;
  WorkTask(this.id, this.input);
}

// [요구사항 2] 무거운 작업을 처리할 Isolate 함수
// 실제로 0.5초 대기하며 input의 제곱을 구한다고 가정합니다.
void worker(SendPort sendPort) async {
  final port = ReceivePort();
  sendPort.send(port.sendPort);

  await for (var task in port) {
    if (task is WorkTask) {
      try {
        // 의도적인 부하 및 에러 상황 시뮬레이션
        if (task.input < 0) throw "음수는 처리할 수 없습니다.";
        await Future.delayed(Duration(milliseconds: 500));
        
        // 성공 결과 전송
        sendPort.send(Success<int>(task.input * task.input));
      } catch (e) {
        // 실패 결과 전송
        sendPort.send(Failure<int>(e.toString()));
      }
    }
  }
}

// [요구사항 3] 메인 스케줄러 클래스
class TaskScheduler {
  Stream<Result<int>> processTasks(List<int> inputs) async* {
    final receivePort = ReceivePort();
    await Isolate.spawn(worker, receivePort.sendPort);

    // Isolate과 통신 준비
    final events = receivePort.asBroadcastStream();
    final SendPort workerSendPort = await events.first;

    for (var input in inputs) {
      workerSendPort.send(WorkTask(inputs.indexOf(input), input));
    }

    // 결과 수집
    // TODO: inputs의 개수만큼 결과를 기다렸다가 yield 하세요.
    // 힌트: await for 또는 events.skip(1).take(inputs.length) 활용
    int count = 0;
    await for (var result in events) {
      if (result is Result<int>) {
        yield result;
        count++;
        if (count == inputs.length) break;
      }
    }
    receivePort.close();
  }
}

void main() async {
  print("🚀 병렬 작업 엔진 가동 (Isolate 활성화)...");
  
  final scheduler = TaskScheduler();
  final numbers = [10, -5, 20, 30, 40];

  // [요구사항 4] 결과 처리 (Pattern Matching 사용)
  await for (final res in scheduler.processTasks(numbers)) {
    final message = switch (res) {
      // TODO: Success와 Failure 케이스를 패턴 매칭으로 처리하세요.
      Success(data: var d) => "✅ 성공: 결과값 $d",
      Failure(error: var e) => "❌ 에러 발생: $e",
    };
    print(message);
  }

  print("🏁 모든 작업 완료");
}
