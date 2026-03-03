import 'package:flutter/material.dart';
import 'package:scroll_views/const/colors.dart';
import 'package:scroll_views/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(100, (index) => index);
  @override
  Widget build(BuildContext context) {
    return MayinLayout(
      title: 'ReorderableListViewScreen',
      body: ReorderableListView.builder(
        itemBuilder: (context, index) {
          return renderContaier(
            color: rainbowColors[numbers[index] % rainbowColors.length],
            index: numbers[index],
          );
        },
        itemCount: numbers.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = numbers.removeAt(oldIndex);
            numbers.insert(newIndex, item);
          });
        },
      ),
    );
  }

  Widget renderDefault() {
    return ReorderableListView(
      children: numbers
          .map(
            (e) => renderContaier(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList(),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
    );
  }
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
