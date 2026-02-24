// 1. 오늘 날짜를 yyyymmdd 형태의 문자열로 반환
String todaysDateFormatted() {
  DateTime now = DateTime.now();
  return convertDateTimeToString(now);
}

// 2. yyyymmdd 형태의 문자열을 DateTime 객체로 변환
DateTime createDateTimeObject(String dateStr) {
  // 혹시 모를 오류를 방지하기 위해 8자리가 맞는지 확인
  if (dateStr.length != 8) {
    throw const FormatException("날짜 형식은 yyyymmdd 8자리여야 합니다.");
  }

  int year = int.parse(dateStr.substring(0, 4));
  int month = int.parse(dateStr.substring(4, 6));
  int day = int.parse(dateStr.substring(6, 8));

  return DateTime(year, month, day);
}

// 3. DateTime 객체를 yyyymmdd 형태의 문자열로 변환
String convertDateTimeToString(DateTime date) {
  String year = date.year.toString();
  // month와 day가 1자리 수일 경우 앞에 '0'을 붙여줌 (예: 5월 -> 05)
  String month = date.month.toString().padLeft(2, '0');
  String day = date.day.toString().padLeft(2, '0');

  return '$year$month$day';
}
