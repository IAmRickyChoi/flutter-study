import 'package:flutter/material.dart';
import 'package:scroll_views/const/colors.dart';
import 'package:scroll_views/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (e) => e);
  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MayinLayout(
      title: 'ListViewScreen',
      body: ListView.separated(
        itemCount: numbers.length,
        separatorBuilder: (context, index) {
          index += 1;
          return (index) % 5 == 0
              ? renderContaier(color: Colors.black, index: index, height: 100)
              : Container();
        },
        itemBuilder: (context, index) {
          return renderContaier(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
      ),
    );
  }

  Widget renderDefault() {
    return ListView(
      children: numbers
          .map(
            (e) => renderContaier(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList(),
    );
  }

  Widget renderBuilder() {
    return ListView.builder(
      itemCount: numbers.length,
      itemBuilder: (context, index) {
        return renderContaier(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  Widget renderSeparated() {
    return ListView.separated(
      itemCount: numbers.length,
      separatorBuilder: (context, index) {
        index += 1;
        return (index) % 5 == 0
            ? renderContaier(color: Colors.black, index: index, height: 100)
            : Container();
      },
      itemBuilder: (context, index) {
        return renderContaier(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  Widget renderContaier({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      height: height ?? 300,
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
