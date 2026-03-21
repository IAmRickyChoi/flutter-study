import 'package:dusty_dust/const/status_level.dart';
import 'package:dusty_dust/models/stat_model.dart';
import 'package:dusty_dust/utils/date_utils.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';

class MainStat extends StatelessWidget {
  final Region region;
  const MainStat({super.key, required this.region});

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(color: Colors.white, fontSize: 40.0);

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: FutureBuilder<StatModel?>(
          future: GetIt.I<Isar>().statModels
              .filter()
              .regionEqualTo(region)
              .itemCodeEqualTo(ItemCode.PM10)
              .sortByDateTimeDesc()
              .findFirst(),

          builder: (context, snapshot) {
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (!snapshot.hasData) {
              return Center(child: Text('데이터가 없습니다'));
            }

            final statModel = snapshot.data!;

            final status = StatusUtils.getStatusModelFromStat(
              statModel: statModel,
            );

            return Column(
              children: [
                Text("서울", style: ts.copyWith(fontWeight: FontWeight.w700)),
                Text(
                  DateUtils.dateTimeToString(dateTime: statModel.dateTime),
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                Image.asset(
                  status.imagePath,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                Text(
                  status.label,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  status.comment,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
