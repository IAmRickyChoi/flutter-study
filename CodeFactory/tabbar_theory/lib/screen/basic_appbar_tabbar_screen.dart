import 'package:flutter/material.dart';
import 'package:tabbar_theory/constant/tabs.dart';

class BasicAppbarTabbarScreen extends StatelessWidget {
  const BasicAppbarTabbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TABs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('BasicAppBarScreen'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TabBar(
                  indicatorColor: Colors.red,
                  indicatorWeight: 4.0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: true,
                  labelColor: Colors.yellow,
                  unselectedLabelColor: Colors.black,
                  labelStyle: TextStyle(fontWeight: FontWeight.w700),
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w100),
                  tabs: TABs.map(
                    (e) => Tab(icon: Icon(e.icon), child: Text(e.label)),
                  ).toList(),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: TABs.map((e) => Center(child: Icon(e.icon))).toList(),
        ),
      ),
    );
  }
}
