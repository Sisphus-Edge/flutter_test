import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:untitled/widges/canlendar.dart';

class Canlendar_petHome extends StatefulWidget {
  final double section_width;
  final double section_height;

  const Canlendar_petHome({super.key, required this.section_width, required this.section_height});

  @override
  _Canlendar_petHomeState createState() => _Canlendar_petHomeState();
}

class _Canlendar_petHomeState extends State<Canlendar_petHome> {
  DateTime _selectedDay = DateTime.now();
  late double section_Width;
  late double section_Height;
  @override
  Widget build(BuildContext context) {
    section_Width = widget.section_width;
    section_Height = widget.section_height;
    return Container(
      child: Stack(
        children: [
          Center(
            child: TableCalendar(
              firstDay: DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
              lastDay: DateTime.now().add(Duration(days: DateTime.daysPerWeek - DateTime.now().weekday)),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.week,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
                // Handle selected date
                print('Selected: $_selectedDay');
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
              ),
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                weekendStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPageChanged: (focusedDay) {},
            ),
          ),
          Positioned(
            top: 9.0,
            right: section_Width*0.1,
            child: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
