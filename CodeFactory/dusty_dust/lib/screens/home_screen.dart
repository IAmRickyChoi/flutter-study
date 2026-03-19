import 'package:dusty_dust/components/category_stat.dart';
import 'package:dusty_dust/components/hourly_stat.dart';
import 'package:dusty_dust/components/main_stat.dart';
import 'package:dusty_dust/const/color.dart';
import 'package:dusty_dust/models/stat_model.dart';
import 'package:dusty_dust/repositories/stat_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: FutureBuilder<List<StatModel>>(
          future: StatRepository.fetchData(itemCode: ItemCode.PM10),
          builder: (context, snapshot) {
            return Column(children: [MainStat(), CategoryStat(), HourlyStat()]);
          },
        ),
      ),
    );
  }
}
