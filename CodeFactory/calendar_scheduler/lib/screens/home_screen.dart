import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/database/drift.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:calendar_scheduler/model/schedule_with_category.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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

  Map<DateTime, List<ScheduleTable>> schedule = {
    DateTime.utc(2026, 2, 21): [
      // ScheduleTable(
      //   id: 1,
      //   starTime: 11,
      //   endTime: 12,
      //   content: 'flutter study',
      //   date: DateTime.utc(2026, 2, 21),
      //   color: categoryColors[0],
      //   createdAt: DateTime.now().toUtc(),
      // ),
      // ScheduleTable(
      //   id: 2,
      //   starTime: 13,
      //   endTime: 14,
      //   content: 'flutter study2',
      //   date: DateTime.utc(2026, 2, 21),
      //   color: categoryColors[3],
      //   createdAt: DateTime.now().toUtc(),
      // ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet<ScheduleTable>(
            context: context,
            builder: (_) {
              return ScheduleBottomSheet(selectedDay: selectedDay);
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
            StreamBuilder(
              stream: GetIt.I<AppDatabase>().streamSchedules(selectedDay),
              builder: (context, snapshot) {
                return TodayBanner(
                  selectedDay: selectedDay,
                  taskCount: !snapshot.hasData ? 0 : snapshot.data!.length,
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: StreamBuilder<List<ScheduleWithCategory>>(
                  stream: GetIt.I<AppDatabase>().streamSchedules(selectedDay),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('has error'));
                    }

                    if (snapshot.data == null) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final schedules = snapshot.data!;

                    return ListView.separated(
                      itemCount: schedules.length,
                      itemBuilder: (BuildContext context, int index) {
                        // final selectedSchedules = schedule[selectedDay]!;
                        // final scheduleModel = selectedSchedules[index];
                        final scheduleWithCategory = schedules[index];
                        final schedule = scheduleWithCategory.schedule;
                        final category = scheduleWithCategory.category;

                        return Dismissible(
                          key: ObjectKey(schedule.id),
                          direction: DismissDirection.endToStart,
                          // confirmDismiss: (DismissDirection direction) async {
                          //   await GetIt.I<AppDatabase>().removeSchedule(
                          //     schedule.id,
                          //   );

                          //   return true;
                          // },
                          onDismissed: (DismissDirection direction) {
                            GetIt.I<AppDatabase>().removeSchedule(schedule.id);
                          },
                          child: GestureDetector(
                            onTap: () async {
                              await showModalBottomSheet<ScheduleTable>(
                                context: context,
                                builder: (_) {
                                  return ScheduleBottomSheet(
                                    selectedDay: selectedDay,
                                    id: schedule.id,
                                  );
                                },
                              );
                            },
                            child: ScheduleCard(
                              startTime: schedule.startTime,
                              endTime: schedule.endTime,
                              content: schedule.content,
                              color: Color(
                                int.parse('FF${category.color}', radix: 16),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 16.0);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(day) {
    return day.isAtSameMomentAs(selectedDay!);
  }
}
