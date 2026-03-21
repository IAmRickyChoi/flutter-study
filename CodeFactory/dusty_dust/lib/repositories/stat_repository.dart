import 'package:dio/dio.dart';
import 'package:dusty_dust/models/stat_model.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';

class StatRepository {
  static Future<void> fetchData() async {
    final isar = GetIt.I<Isar>();

    final now = DateTime.now();
    final compareDateTimeGarget = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
    );

    final count = await isar.statModels
        .filter()
        .dateTimeEqualTo(compareDateTimeGarget)
        .count();

    if (count > 0) {
      print('데이터가 존재합니다 : count $count');
      return;
    }

    for (ItemCode itemCode in ItemCode.values) {
      await fetchDataByItemCode(itemCode: itemCode);
    }
  }

  static Future<List<StatModel>> fetchDataByItemCode({
    required ItemCode itemCode,
  }) async {
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey':
            '3a8192d26d60e9ab02ee5e74e14972d654aa1b2feed2b08d62b4f42edf628280',
        'returnType': 'json',
        'numOfRows': 100,
        'pageNo': 1,
        'itemCode': itemCode.name,
        'dataGubun': 'HOUR',
        'searchConditon': 'WEEK',
      },
    );

    final rawItemList = response.data['response']['body']['items'];

    List<StatModel> stats = [];

    final List<String> skipKeys = ['dataGubun', 'dataTime', 'itemCode'];

    for (Map<String, dynamic> item in rawItemList) {
      final dateTime = DateTime.parse(item['dataTime']);
      for (String key in item.keys) {
        if (skipKeys.contains(key)) {
          continue;
        }

        final regionStr = key;
        final stat = double.parse(item[regionStr]);
        final region = Region.values.firstWhere((e) => e.name == regionStr);

        final statModel = StatModel()
          ..region = region
          ..stat = stat
          ..dateTime = dateTime
          ..itemCode = itemCode;

        final isar = GetIt.I<Isar>();

        final count = await isar.statModels
            .filter()
            .regionEqualTo(region)
            .dateTimeEqualTo(dateTime)
            .itemCodeEqualTo(itemCode)
            .count();

        if (count > 0) {
          continue;
        }

        await isar.writeTxn(() async {
          return await isar.statModels.put(statModel);
        });
        // stats = [
        //   ...stats,

        //   StatModel(
        //     region: Region.values.firstWhere((e) => e.name == regionStr),
        //     stat: double.parse(stat),
        //     dateTime: DateTime.parse(dateTime),
        //     itemCode: itemCode,
        //   ),
        // ];
      }
    }
    return stats;
  }
}
