import 'dart:async';
import 'dart:io'; // 코어 개수 확인용
import 'dart:isolate';

// 1. 결과 패턴 정의
sealed class Result<T> {}
class Success<T> extends Result<T> {
  final T value;
  Success(this.value);
}
class Failure<T> extends Result<T> {
  final String error;
  Failure(this.error);
}

// 2. 워커 함수 (일꾼)
void worker(SendPort mainSendPort) async {
  final rp = ReceivePort();
  mainSendPort.send(rp.sendPort); // 내 주소 알림

  await for (final message in rp) {
    if (message == null) break;
    final int input = message;
    
    // 복잡한 연산 시뮬레이션
    if (input < 0) {
      mainSendPort.send(Failure<int>("음수 제외: $input"));
    } else {
      mainSendPort.send(Success<int>(input * input));
    }
  }
}

// 3. 워커 풀 스케줄러
class WorkerPool {
  final int coreCount = Platform.numberOfProcessors; // 내 CPU 코어 개수 확인
  final List<Isolate> _isolates = [];
  final List<SendPort> _workerPorts = [];
  final ReceivePort _mainReceivePort = ReceivePort();

  // 워커들을 미리 준비시키는 함수
  Future<void> init() async {
    print("🔧 시스템 탐색: $coreCount개의 코어를 발견했습니다. 워커를 생성합니다...");
    for (int i = 0; i < coreCount; i++) {
      final isolate = await Isolate.spawn(worker, _mainReceivePort.sendPort);
      _isolates.add(isolate);
    }

    // 모든 워커의 SendPort를 수집 (Handshake)
    final portStream = StreamIterator(_mainReceivePort);
    for (int i = 0; i < coreCount; i++) {
      if (await portStream.moveNext()) {
        _workerPorts.add(portStream.current as SendPort);
      }
    }
  }

  // 작업을 분산해서 처리
  Stream<Result<int>> processAll(List<int> tasks) async* {
    int taskIndex = 0;
    int completedTasks = 0;

    // 1. 처음 코어 개수만큼 일감을 하나씩 배분
    for (int i = 0; i < coreCount && i < tasks.length; i++) {
      _workerPorts[i].send(tasks[taskIndex++]);
    }

    // 2. 결과가 올 때마다 다음 남은 일감을 전달 (Round-robin)
    await for (final result in _mainReceivePort) {
      yield result as Result<int>;
      completedTasks++;

      if (taskIndex < tasks.length) {
        // 노는 일꾼에게 다음 일감 주기
        (result is Success) ? null : null; // 단순히 순서 제어용
        _workerPorts[completedTasks % coreCount].send(tasks[taskIndex++]);
      }

      if (completedTasks == tasks.length) break;
    }
  }

  void dispose() {
    for (var port in _workerPorts) port.send(null);
    for (var isolate in _isolates) isolate.kill();
    _mainReceivePort.close();
    print("🧹 모든 워커를 해고(종료)했습니다.");
  }
}

void main() async {
  print("🚀 멀티코어 병렬 엔진 시작");
  final pool = WorkerPool();
  await pool.init();

  final data = List.generate(20, (i) => i + 1); // 1부터 20까지 작업

  await for (final res in pool.processAll(data)) {
    if (res is Success) print("✅ 결과 수신: ${res.value}");
  }

  pool.dispose();
  print("🏁 모든 작업 완료");
}
