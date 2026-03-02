import 'package:flutter/material.dart';
import 'package:scroll_views/const/colors.dart';
import 'package:scroll_views/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  SingleChildScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MayinLayout(
      title: 'SingleChildScrollViewScreen',
      body: renderPerformance(),
    );
  }

  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors.map((e) => renderContaier(color: e)).toList(),
      ),
    );
  }

  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      ///NeverScrollableScrollPhysics
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(children: [renderContaier(color: Colors.blue)]),
    );
  }

  Widget renderClip() {
    return SingleChildScrollView(
      clipBehavior: Clip.none,

      ///NeverScrollableScrollPhysics
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(children: [renderContaier(color: Colors.blue)]),
    );
  }

  Widget renderPhysics() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: rainbowColors.map((e) => renderContaier(color: e)).toList(),
      ),
    );
  }

  Widget renderPerformance() {
    return SingleChildScrollView(
      child: Column(
        children: numbers
            .map(
              (e) => renderContaier(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget renderContaier({required Color color, int? index}) {
    print(index);
    return Container(height: 300, color: color);
  }
}
