import 'package:flutter/material.dart';

class NumberToImage extends StatelessWidget {
  final int number;
  const NumberToImage({super.key,required this.number});

  @override
  Widget build(BuildContext context) {
    return Row(
              children: number.toString().split('').map((e) {
                return Image.asset(
                  'asset/img/$e.png',
                  width: 50.0,
                  height: 70.0,
                );
              }).toList(),
            );
  }
}