import 'package:flutter/material.dart';
import 'package:scroll_views/layout/main_layout.dart';
import 'package:scroll_views/screen/custom_scroll_view_screen.dart';
import 'package:scroll_views/screen/grid_view_screen.dart';
import 'package:scroll_views/screen/list_view_screen.dart';
import 'package:scroll_views/screen/refresh_indicator_screen.dart';
import 'package:scroll_views/screen/reorderable_list_view_screen.dart';
import 'package:scroll_views/screen/scrollbar_screen.dart';
import 'package:scroll_views/screen/single_child_scroll_view_screen.dart';

class ScreenModel {
  final WidgetBuilder builder;
  final String name;
  ScreenModel({required this.builder, required this.name});
}

class HomeScreen extends StatelessWidget {
  final screens = [
    ScreenModel(
      builder: (_) => SingleChildScrollViewScreen(),
      name: 'SingleChildScrollViewScreen',
    ),
    ScreenModel(builder: (_) => ListViewScreen(), name: 'ListViewScreen'),
    ScreenModel(builder: (_) => GridViewScreen(), name: 'GridViewScreen'),
    ScreenModel(
      builder: (_) => ReorderableListViewScreen(),
      name: 'ReorderableListViewScreen',
    ),
    ScreenModel(
      builder: (_) => CustomScrollViewScreen(),
      name: 'CustomScrollViewScreen',
    ),
    ScreenModel(builder: (_) => ScrollbarScreen(), name: 'ScrollbarScreen'),
    ScreenModel(
      builder: (_) => RefreshIndicatorScreen(),
      name: 'RefreshIndicator',
    ),
  ];
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MayinLayout(
      title: 'Home',
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: screens
              .map(
                (e) => ElevatedButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: e.builder));
                  },
                  child: Text(e.name),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
