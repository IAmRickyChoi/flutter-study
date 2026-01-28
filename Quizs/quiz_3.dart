// [요구사항 1] Sealed Class 정의
sealed class Transaction {
  final String description;
  final double amount;
  Transaction(this.description, this.amount);
}

class Income extends Transaction {
  Income(String description, double amount) : super(description, amount);
}

class Expense extends Transaction {
  final String category;
  Expense(String description, double amount, this.category) : super(description, amount);
}

// [요구사항 2 & 3] List 확장 메서드와 Named Record
extension TransactionAnalysis on List<Transaction> {
  // TODO: 이름이 있는 레코드 ({double totalIncome, double totalExpense, int count})를 반환하세요.
  ({double totalIncome, double totalExpense, int count}) getSummary() {
    return fold(
      (totalIncome: 0.0, totalExpense: 0.0, count: 0),
      (acc, tx) => switch (tx) {
        // TODO: 패턴 매칭을 사용하여 Income일 때와 Expense일 때의 계산식을 완성하세요.
        Income(:var amount) => (
            totalIncome: acc.totalIncome + amount,
            totalExpense: acc.totalExpense,
            count: acc.count + 1
          ),
        Expense(:var amount) => (
            totalIncome: acc.totalIncome,
            totalExpense: acc.totalExpense + amount,
            count: acc.count + 1
          ),
      },
    );
  }
}

void main() {
  final history = [
    Income("월급", 5000000),
    Expense("아이패드", 1200000, "전자기기"),
    Expense("커피", 5000, "식비"),
    Income("중고거래", 30000),
    Expense("월세", 600000, "주거"),
  ];

  // TODO 1: 확장 메서드를 호출하여 요약 데이터를 받으세요.
  final summary = history.getSummary();

  print("📊 거래 요약:");
  print("총 수입: ${summary.totalIncome}원");
  print("총 지출: ${summary.totalExpense}원");
  print("항목 수: ${summary.count}개");

  print("\n⚠️ 고액 지출 알림 (10만원 초과):");
  
  // TODO 2: history를 순회하며 '패턴 매칭'을 사용해 
  // 10만원 초과 Expense만 찾아 "항목: [설명], 금액: [금액]"을 출력하세요.
  for (var tx in history) {
    if (tx case Expense(description: var d, amount: var a) when a > 100000) {
      print("항목: $d, 금액: $a원");
    }
  }
}
