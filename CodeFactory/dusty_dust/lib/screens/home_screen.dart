import 'package:dusty_dust/components/category_stat.dart';
import 'package:dusty_dust/components/hourly_stat.dart';
import 'package:dusty_dust/components/main_stat.dart';
import 'package:dusty_dust/models/stat_model.dart';
import 'package:dusty_dust/repositories/stat_repository.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isExpanded = true;
  Region region = Region.seoul;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    StatRepository.fetchData();

    scrollController.addListener(() {
      bool isExpanded = scrollController.offset < (500 - kToolbarHeight);

      if (isExpanded != this.isExpanded) {
        setState(() {
          this.isExpanded = isExpanded;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatModel?>(
      future: GetIt.I<Isar>().statModels
          .filter()
          .regionEqualTo(region)
          .itemCodeEqualTo(ItemCode.PM10)
          .sortByDateTimeDesc()
          .findFirst(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(body: CircularProgressIndicator());
        }

        final statModel = snapshot.data!;
        final statusModel = StatusUtils.getStatusModelFromStat(
          statModel: statModel,
        );

        return Scaffold(
          drawer: Drawer(
            backgroundColor: statusModel.darkColor,
            child: ListView(
              children: [
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  child: Text(
                    '지역 선택',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                ...Region.values
                    .map(
                      (e) => ListTile(
                        tileColor: Colors.white,
                        selectedTileColor: statusModel.lightColor,
                        selectedColor: Colors.black,
                        selected: e == region,
                        onTap: () {
                          setState(() {
                            region = e;
                          });
                          Navigator.pop(context);
                        },
                        title: Text(e.krName),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          backgroundColor: statusModel.primaryColor,
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              MainStat(
                primaryColor: statusModel.primaryColor,
                darkColor: statusModel.darkColor,
                lightColor: statusModel.lightColor,
                region: region,
                isExpanded: isExpanded,
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CategoryStat(
                      darkColor: statusModel.darkColor,
                      lightColor: statusModel.lightColor,
                      region: region,
                    ),
                    HourlyStat(
                      darkColor: statusModel.darkColor,
                      lightColor: statusModel.lightColor,
                      region: region,
                    ),
                  ],
                ),
              ),
            ],
            //  Column(
            //   children: [
            //     MainStat(
            //       darkColor: statusModel.darkColor,
            //       lightColor: statusModel.lightColor,
            //       region: region,
            //     ),
            //     CategoryStat(
            //       darkColor: statusModel.darkColor,
            //       lightColor: statusModel.lightColor,
            //       region: region,
            //     ),
            //     HourlyStat(
            //       darkColor: statusModel.darkColor,
            //       lightColor: statusModel.lightColor,
            //       region: region,
            //     ),
            //   ],
            // ),
          ),
        );
      },
    );
  }
}
