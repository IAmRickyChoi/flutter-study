import 'package:flutter/material.dart';
import 'package:home_page/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.maxLine,
    required this.hintText,
  });
  final TextEditingController controller;
  final int maxLine;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: CustomColor.scaffoldBg,
      style: const TextStyle(color: CustomColor.scaffoldBg),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16),
        filled: true,
        fillColor: CustomColor.whiteSecondary,
        focusedBorder: getInputBorder,
        enabledBorder: getInputBorder,
        border: getInputBorder,
        hintText: 'Your name',
        hintStyle: TextStyle(color: CustomColor.hintDark),
      ),
    );
  }

  OutlineInputBorder get getInputBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  );
}
