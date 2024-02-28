import 'package:flutter/material.dart';
import 'package:untitled/db/DailyRecordDB/dailyrecord_db_manager.dart';
// import 'dailyrecord_db_manager.dart';


class DailyRecordPage extends StatefulWidget {
  @override
  _DailyRecordPageState createState() => _DailyRecordPageState();
}

class _DailyRecordPageState extends State<DailyRecordPage> {
  final dbManager = DailyRecordDBManager();
  List<DailyRecord> dailyRecords = [];
  List<Habit> habits = [];

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    final allDailyRecords = await dbManager.getAllDailyRecords();
    final allHabits = await dbManager.getAllHabits();
    setState(() {
      dailyRecords = allDailyRecords;
      habits = allHabits;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Records'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Records:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dailyRecords.length,
              itemBuilder: (context, index) {
                final record = dailyRecords[index];
                return ListTile(
                  title: Text('Date: ${record.recordDate}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Exercise Goal: ${record.exerciseGoal}'),
                      Text('Exercise Completed: ${record.exerciseCompleted}'),
                      Text('Nutrition Goal: ${record.nutritionGoal}'),
                      Text('Nutrition Completed: ${record.nutritionCompleted}'),
                      Text('Water Goal: ${record.waterGoal}'),
                      Text('Water Completed: ${record.waterCompleted}'),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Habits:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                final habit = habits[index];
                return ListTile(
                  title: Text('Habit Name: ${habit.habitName}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Start Date: ${habit.startDate}'),
                      Text('End Date: ${habit.endDate}'),
                      Text('Monday: ${habit.monday ==0 ? 'Yes' : 'No'}'),
                      Text('Tuesday: ${habit.tuesday == 0? 'Yes' : 'No'}'),
                      Text('Wednesday: ${habit.wednesday ==0? 'Yes' : 'No'}'),
                      Text('Thursday: ${habit.thursday==0 ? 'Yes' : 'No'}'),
                      Text('Friday: ${habit.friday ==0? 'Yes' : 'No'}'),
                      Text('Saturday: ${habit.saturday ==0? 'Yes' : 'No'}'),
                      Text('Sunday: ${habit.sunday ==0? 'Yes' : 'No'}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
