import 'package:dusty_dust/const/status_level.dart';
import 'package:dusty_dust/models/stat_model.dart';
import 'package:dusty_dust/utils/date_utils.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';

class MainStat extends StatelessWidget {
  final Color primaryColor;
  final Color darkColor;
  final Color lightColor;
  final Region region;
  final bool isExpanded;
  const MainStat({
    super.key,
    required this.primaryColor,
    required this.darkColor,
    required this.lightColor,
    required this.region,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(color: Colors.white, fontSize: 40.0);

    return SliverAppBar(
      backgroundColor: primaryColor,
      expandedHeight: 450,
      pinned: true,
      title: isExpanded ? null : Text('${region.krName}'),
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
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
                    SizedBox(height: kToolbarHeight),
                    Text(
                      region.krName,
                      style: ts.copyWith(fontWeight: FontWeight.w700),
                    ),
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
        ),
      ),
    );
  }
}
