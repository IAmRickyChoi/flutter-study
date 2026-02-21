import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/database/drift.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDay;
  const ScheduleBottomSheet({super.key, required this.selectedDay});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;

  String selectedColor = categoryColors.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 600.0,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.only(left: 16.0, right: 16.0, top: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _Time(
                  onEndSaved: onEndTimeSaved,
                  onEndValidate: onEndTimeValidate,
                  onStartSaved: onStartTimeSaved,
                  onStartValidate: onStartTimeValidate,
                ),
                SizedBox(height: 8.0),
                _Content(
                  onSaved: onContentSaved,
                  onValidate: onContentValidate,
                ),
                SizedBox(height: 8.0),
                _Categories(
                  selectedColor: selectedColor,
                  onTap: (String color) {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                ),
                SizedBox(height: 8.0),
                _SaveButton(onPressed: onSavedPressed),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onStartTimeSaved(String? val) {
    if (val == null) return;
    startTime = int.parse(val);
  }

  String? onStartTimeValidate(String? val) {
    if (val == null) return "값을 입력해주세요";

    if (int.tryParse(val) == null) return "숫자를 입력해주세요";

    final time = int.tryParse(val)!;
    if (time > 24 || time < 0) {
      return 'between 0~24';
    }
  }

  void onEndTimeSaved(String? val) {
    if (val == null) return;
    endTime = int.parse(val);
  }

  String? onEndTimeValidate(String? val) {
    if (val == null) return "값을 입력해주세요";

    if (int.tryParse(val) == null) return "숫자를 입력해주세요";

    final time = int.tryParse(val)!;
    if (time > 24 || time < 0) {
      return 'between 0~24';
    }
  }

  void onContentSaved(String? val) {
    if (val == null) return;
    content = val;
  }

  String? onContentValidate(String? val) {
    if (val == null) return "값을 입력해주세요";

    if (val.length < 5) {
      return 'more than 5';
    }
  }

  void onSavedPressed() async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      formKey.currentState!.save();

      final database = GetIt.I<AppDatabase>();

      await database.createSchedule(
        ScheduleTableCompanion(
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          color: Value(selectedColor),
          date: Value(widget.selectedDay),
        ),
      );

      Navigator.of(context).pop();
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final FormFieldValidator<String> onStartValidate;
  final FormFieldValidator<String> onEndValidate;
  _Time({
    required this.onStartSaved,
    required this.onEndSaved,
    required this.onStartValidate,
    required this.onEndValidate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: '시작 시간',
            onSaved: onStartSaved,
            validator: onStartValidate,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: CustomTextField(
            label: '마감 시간',
            onSaved: onEndSaved,
            validator: onEndValidate,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidate;

  const _Content({super.key, required this.onSaved, required this.onValidate});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
        onSaved: onSaved,
        validator: onValidate,
      ),
    );
  }
}

typedef OnColorSelected = void Function(String color);

class _Categories extends StatelessWidget {
  final OnColorSelected onTap;
  final String selectedColor;
  const _Categories({
    super.key,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categoryColors
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  onTap(e);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(int.parse('FF$e', radix: 16)),
                    shape: BoxShape.circle,
                    border: e == selectedColor
                        ? Border.all(color: Colors.black, width: 4.0)
                        : null,
                  ),
                  width: 32.0,
                  height: 32.0,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}
