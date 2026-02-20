import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/screens/custom_text_field.dart';
import 'package:calendar_scheduler/screens/schedule_card.dart';
import 'package:calendar_scheduler/screens/today_banner.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return Container(
                color: Colors.white,
                height: 600.0,
                child: Padding(
                  padding: EdgeInsetsGeometry.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: '시작 시간',
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: CustomTextField(
                              label: '마감 시간',
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: CustomTextField(
                          label: '내용',
                          expand: true,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              focusedDay: DateTime(2026, 2, 1),
              onDaySelected: onDaySelected,
              selectedDayPredicate: selectedDayPredicate,
            ),
            TodayBanner(
              selectedDay: selectedDay,
              taskCount: 0,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: ListView(
                  children: [
                    ScheduleCard(
                      endTime: DateTime(2026, 02, 21, 03),
                      startTime: DateTime(2026, 02, 21, 13),
                      color: Colors.blue,
                      content: '플러터 공부하기',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
  ) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(day) {
    if (selectedDay == null) {
      return false;
    }
    return day.isAtSameMomentAs(selectedDay!);
  }
}
