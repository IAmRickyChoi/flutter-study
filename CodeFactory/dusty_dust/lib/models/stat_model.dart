enum Region {
  daegu,
  chungnam,
  incheon,
  daejeon,
  gyeongbuk,
  sejong,
  gwangju,
  jeonbuk,
  gangwon,
  ulsan,
  jeonnam,
  seoul,
  busan,
  jeju,
  chungbuk,
  gyeongnam,
  gyeonggi;

  String get krName {
    switch (this) {
      case Region.daegu:
        return '대구';
      case Region.chungnam:
        return '충남';
      case Region.incheon:
        return '인천';
      case Region.daejeon:
        return '대전';
      case Region.gyeongbuk:
        return '경북';
      case Region.sejong:
        return '세종';
      case Region.gwangju:
        return '광주';
      case Region.jeonbuk:
        return '전북';
      case Region.gangwon:
        return '강원';
      case Region.ulsan:
        return '울산';
      case Region.jeonnam:
        return '전남';
      case Region.seoul:
        return '서울';
      case Region.busan:
        return '부산';
      case Region.jeju:
        return '제주';
      case Region.chungbuk:
        return '충북';
      case Region.gyeongnam:
        return '경남';
      case Region.gyeonggi:
        return '경기';
    }
  }
}

enum ItemCode {
  SO2,
  CO,
  O3,
  NO2,
  PM10,
  PM25;

  String get krName {
    switch (this) {
      case ItemCode.SO2:
        return "이황산가스";
      case ItemCode.CO:
        return "이황산가스";
      case ItemCode.O3:
        return "이황산가스";
      case ItemCode.NO2:
        return "이황산가스";
      case ItemCode.PM10:
        return "이황산가스";
      case ItemCode.PM25:
        return "이황산가스";
    }
  }
}

class StatModel {
  final Region region;
  final double stat;
  final DateTime dateTime;
  final ItemCode itemCode;

  StatModel({
    required this.region,
    required this.stat,
    required this.dateTime,
    required this.itemCode,
  });
}
