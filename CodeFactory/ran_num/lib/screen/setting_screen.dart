import 'package:flutter/material.dart';
import 'package:ran_num/component/number_to_image.dart';
import 'package:ran_num/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int maxNumber;
  const SettingScreen({super.key,required this.maxNumber});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    super.initState();
  maxNumber=widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Slider(value:maxNumber,onChanged: onSliderChanged,),
              _Number(maxNumber: maxNumber,),
              _Button(onPressed: onSavePressed,)],
          ),
        ),
      ),
    );

  }
    onSavePressed(){
      Navigator.of(context).pop(maxNumber.toInt());
    }

  onSliderChanged(double value){
    setState(() {
      maxNumber=value;
    });
  }

}

class _Button extends StatelessWidget {
  final VoidCallback onPressed;
  const _Button({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: redColor,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text('저장'),
    );
  }
}

class _Slider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  const _Slider({super.key,required this.value,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value, 
      min: 1000,
      max: 10000,
      onChanged: onChanged,
      activeColor: redColor,
      );
  }
}

class _Number extends StatelessWidget {
  final double maxNumber;
  const _Number({super.key,required this.maxNumber});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: NumberToImage(number: maxNumber.toInt())
      )
    );
  }
}