class CounterRepository {
  Future<int> increment(int currentValue) async {
    return currentValue + 1;
  }
}
