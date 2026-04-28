import 'package:actual/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    this.onChanged,
  });
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(color: INPUT_BG_COLOR, width: 1.0),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      obscureText: true,
      autofocus: true,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(color: BODY_TEXt_COLOR, fontSize: 14.0),
        fillColor: INPUT_BG_COLOR,
        //false - 배경색 없음 , true - 배경색 있음
        filled: true,
        //모든 Input 상태의 기본 스타일 세팅
        border: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
