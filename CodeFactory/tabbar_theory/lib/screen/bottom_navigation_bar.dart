import 'package:flutter/material.dart';
import 'package:tabbar_theory/constant/tabs.dart';

class BottomNavigationBarr extends StatefulWidget {
  const BottomNavigationBarr({super.key});

  @override
  State<BottomNavigationBarr> createState() => _BottomNavigationBarrState();
}

class _BottomNavigationBarrState extends State<BottomNavigationBarr>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: TABs.length, vsync: this);
    tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bottom Navigation Bar')),
      body: TabBarView(
        controller: tabController,
        children: TABs.map((e) => Center(child: Icon(e.icon))).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: tabController.index,
        type: BottomNavigationBarType.shifting,
        onTap: (value) {
          tabController.animateTo(value);
        },
        items: TABs.map(
          (e) => BottomNavigationBarItem(icon: Icon(e.icon), label: e.label),
        ).toList(),
      ),
    );
  }
}
