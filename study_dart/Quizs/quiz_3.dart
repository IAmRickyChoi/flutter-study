// [요구사항 1] 봉인된 클래스로 할인 정책 설계
sealed class Discount {}
class Percentage extends Discount { final double rate; Percentage(this.rate); }
class Fixed extends Discount { final int amount; Fixed(this.amount); }
class Bundle extends Discount { 
  final int minCount; 
  final int discountAmount; 
  Bundle(this.minCount, this.discountAmount); 
}

// 장바구니 아이템 타입 별칭 (이름이 있는 레코드 활용)
typedef CartItem = ({String name, int price, int count, Discount? discount});

// [요구사항 4] 리스트 확장 메서드 구현
extension DiscountEngine on List<CartItem> {
  // TODO: 최종 가격과 할인 총액을 이름이 있는 레코드로 반환하는 함수를 작성하세요.
  ({double finalPrice, double totalDiscount}) calculateTotal() {
    return fold(
      (finalPrice: 0.0, totalDiscount: 0.0),
      (acc, item) {
        // 아이템별 원가 계산
        final originalTotal = item.price * item.count;
        
        // [요구사항 3] 패턴 매칭과 'when' 절을 사용하여 할인액(itemDiscount)을 계산하세요.
        // 1. Percentage: 원가 * rate
        // 2. Fixed: amount (단, 원가보다 클 수 없음)
        // 3. Bundle: item.count가 minCount 이상일 때만 discountAmount 적용
        // 4. null 혹은 미해당: 0.0
        double itemDiscount = switch (item.discount) {
          // TODO: 이곳에 패턴 매칭 로직을 작성하세요.
          _______ => _______,
          _______ => _______,
          _______ => _______,
          _ => 0.0,
        };

        return (
          finalPrice: acc.finalPrice + (originalTotal - itemDiscount),
          totalDiscount: acc.totalDiscount + itemDiscount,
        );
      },
    );
  }
}

void main() {
  final List<CartItem> cart = [
    (name: "맥북", price: 2000000, count: 1, discount: Percentage(0.1)), // 10% 할인
    (name: "마우스", price: 50000, count: 3, discount: Bundle(2, 10000)), // 2개 이상 구매 시 1만원 할인
    (name: "키보드", price: 150000, count: 1, discount: Fixed(200000)),  // 20만원 할인(원가보다 크므로 예외처리 필요)
    (name: "장패드", price: 20000, count: 1, discount: null),            // 할인 없음
  ];

  print("🛒 장바구니 결제 분석 중...");

  // TODO: 확장 메서드를 호출하여 결과를 얻고 구조 분해를 통해 출력하세요.
  final _______ = cart.calculateTotal();

  print("--------------------------------");
  print("최종 결제 금액: ${finalPrice.toStringAsFixed(0)}원");
  print("총 할인 금액: ${totalDiscount.toStringAsFixed(0)}원");
  print("--------------------------------");
}
