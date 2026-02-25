// 1. 모든 카운터 이벤트의 부모 (기본 틀)
abstract class CounterEvent {}

// 2. 더하기 버튼을 눌렀을 때 던질 주문서
class CounterIncrementPressed extends CounterEvent {}

// 3. 빼기 버튼을 눌렀을 때 던질 주문서
class CounterDecrementPressed extends CounterEvent {}
