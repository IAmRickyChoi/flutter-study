import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? selectedDay;
  @override
  Widget build(BuildContext context) {
    final defaultBoxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: Colors.grey[200]!, width: 1.0),
    );
    final defaultTextStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w700,
    );

    return Scaffold(
      body: SafeArea(
        child: TableCalendar(
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            defaultDecoration: defaultBoxDecoration,
            weekendDecoration: defaultBoxDecoration,
            selectedDecoration: defaultBoxDecoration.copyWith(
              border: Border.all(color: primaryColor, width: 1.0),
            ),
            todayDecoration: defaultBoxDecoration.copyWith(color: primaryColor),
            outsideDecoration: defaultBoxDecoration.copyWith(
              border: Border.all(color: Colors.transparent),
            ),
            defaultTextStyle: defaultTextStyle,
            weekendTextStyle: defaultTextStyle,
            selectedTextStyle: defaultTextStyle.copyWith(color: primaryColor),
          ),
          focusedDay: DateTime(2026, 1, 20),
          firstDay: DateTime(1800),
          lastDay: DateTime(3000),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              this.selectedDay = selectedDay;
            });
          },
          selectedDayPredicate: (day) {
            if (selectedDay == null) {
              return false;
            }
            return day.isAtSameMomentAs(selectedDay!);
          },
        ),
      ),
    );
  }
}
