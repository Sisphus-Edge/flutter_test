import 'package:flutter/material.dart';
import 'package:untitled/db/DailyRecordDB/dailyrecord_db_manager.dart';
import 'package:drift/drift.dart' as drift;
class DeleteHabitPage extends StatefulWidget {
  @override
  _DeleteHabitPageState createState() => _DeleteHabitPageState();
}

class _DeleteHabitPageState extends State<DeleteHabitPage> {
  late Future<List<Habit>> _habitsFuture;
  late List<Habit> _selectedHabits = [];

  @override
  void initState() {
    super.initState();
    _habitsFuture = fetchAllHabits();
  }

  Future<List<Habit>> fetchAllHabits() async {
    return await DailyRecordDBManager().getAllHabits();
  }

  void deleteSelectedHabits() async {
    for (var habit in _selectedHabits) {
      await DailyRecordDBManager().deleteHabit(habit.habitId);
    }
    setState(() {
      _habitsFuture = fetchAllHabits();
      _selectedHabits.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('删除习惯', style: TextStyle(fontFamily: 'ZHUOKAI',letterSpacing: 2),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 返回上一页
            // Navigator.pop(context); // 返回上一页
          },
        ),
        actions: [
          IconButton(
            onPressed: _selectedHabits.isNotEmpty ? () {
              deleteSelectedHabits();
              Navigator.pop(context); // 返回上一页
              Navigator.pop(context); // 返回上一页

            } : null,
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: FutureBuilder<List<Habit>>(
        future: _habitsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final habit = snapshot.data![index];
                final isSelected = _selectedHabits.contains(habit);
                return ListTile(
                  title: Text(habit.habitName??'散步'),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        if (isSelected) {
                          _selectedHabits.remove(habit);
                        } else {
                          _selectedHabits.add(habit);
                        }
                      });
                    },
                    icon: isSelected ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}