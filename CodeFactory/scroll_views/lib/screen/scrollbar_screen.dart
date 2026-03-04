import 'package:flutter/material.dart';
import 'package:scroll_views/const/colors.dart';
import 'package:scroll_views/layout/main_layout.dart';

class ScrollbarScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  ScrollbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MayinLayout(
      title: 'ScrollbarScreen',
      body: Scrollbar(
        child: SingleChildScrollView(
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
        ),
      ),
    );
  }

  Widget renderContaier({required Color color, int? index}) {
    print(index);
    return Container(
      key: Key(index.toString()),
      height: 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
