import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;
  final String content;
  final Color color;

  const ScheduleCard({
    super.key,
    required this.endTime,
    required this.startTime,
    required this.color,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Text(
                    '${startTime.hour.toString().padLeft(2, '0')}:00',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${endTime.hour.toString().padLeft(2, '0')}:00',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.0),
              Expanded(child: Text(content)),
              Container(
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                width: 16.0,
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
