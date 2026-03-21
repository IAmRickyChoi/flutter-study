import 'package:dusty_dust/const/color.dart';
import 'package:dusty_dust/models/stat_model.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';

class HourlyStat extends StatelessWidget {
  final Color darkColor;
  final Color lightColor;
  final Region region;
  const HourlyStat({
    super.key,
    required this.darkColor,
    required this.lightColor,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ItemCode.values
          .map(
            (itemCode) => FutureBuilder(
              future: GetIt.I<Isar>().statModels
                  .filter()
                  .regionEqualTo(region)
                  .itemCodeEqualTo(itemCode)
                  .sortByDateTimeDesc()
                  .limit(24)
                  .findAll(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                final stats = snapshot.data!;
                return SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      color: lightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: darkColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: Text(
                                '시간별 ${itemCode.krName}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          ...stats.map(
                            (stat) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 4.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${stat.dateTime.hour.toString().padLeft(2, '0')}시',
                                    ),
                                  ),
                                  Expanded(
                                    child: Image.asset(
                                      StatusUtils.getStatusModelFromStat(
                                        statModel: stat,
                                      ).imagePath,
                                      height: 20.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      StatusUtils.getStatusModelFromStat(
                                        statModel: stat,
                                      ).label,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
}
