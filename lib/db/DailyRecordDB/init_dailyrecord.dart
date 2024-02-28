import 'package:drift/drift.dart' as drift;
import 'dailyrecord_db_manager.dart';


Future<void> initializeDailyRecordDatabase() async {
  final db = DailyRecordDBManager();

  final habitsData = [
    {'HabitName':'跑步', 'monday':'1', 'tuesday':'1', 'wednesday':'1', 'thursday':'1','friday':'1', 'saturday':'1','sunday':'1','start_date':'2024-01-01', 'end_date':'2025-01-01'},
    {'HabitName':'吃鱼油', 'monday':'1', 'tuesday':'1', 'wednesday':'1', 'thursday':'1','friday':'1', 'saturday':'1','sunday':'1','start_date':'2024-01-01', 'end_date':'2025-01-01'},
  ];



  for(var habitData in habitsData){
    final existingHabit = await db.getHabitByName(habitData['HabitName']!);
    // String? startDateString = habitData['start_date']; // Assuming this is the string representation of the start date
    // String? endDateString = habitData['end_date']; // Assuming this is the string representation of the start date
    // DateTime? startDate = DateTime.parse(startDateString!);
    // DateTime? endDate = DateTime.parse(endDateString!);

    DateTime? start_Date = DateTime.parse(habitData['start_date']!);
    DateTime? end_Date = DateTime.parse(habitData['end_date']!);

    if (existingHabit == null) {
      await db.addHabit(HabitsCompanion(
        habitName: drift.Value(habitData['HabitName'] as String),
        monday: drift.Value(habitData['monday'] == '1'), // 将 '1' 转换为 true
        tuesday: drift.Value(habitData['tuesday'] == '1'), // 将 '1' 转换为 true
        wednesday: drift.Value(habitData['wednesday'] == '1'), // 将 '1' 转换为 true
        thursday: drift.Value(habitData['thursday'] == '1'), // 将 '1' 转换为 true
        friday: drift.Value(habitData['friday'] == '1'), // 将 '1' 转换为 true
        saturday: drift.Value(habitData['saturday'] == '1'), // 将 '1' 转换为 true
        sunday: drift.Value(habitData['sunday'] == '1'), // 将 '1' 转换为 true
        startDate: drift.Value(start_Date),
        endDate: drift.Value(end_Date),
      ));
    }


  }
  print("习惯数据插入完成");

  final recordDatas = [
    {'RecordDate':'2024-02-26', 'exercise_goal':'60', 'exercise_completed':'40', 'nutrition_goal':'2000',  'nutrition_completed':'800', 'water_goal':'400', 'water_completed':'100','score':'4'},
    {'RecordDate':'2024-02-27', 'exercise_goal':'60', 'exercise_completed':'40', 'nutrition_goal':'2000',  'nutrition_completed':'800', 'water_goal':'400', 'water_completed':'100','score':'3'},
    {'RecordDate':'2024-02-28', 'exercise_goal':'60', 'exercise_completed':'40', 'nutrition_goal':'2000',  'nutrition_completed':'800', 'water_goal':'400', 'water_completed':'100','score':'1'},
    {'RecordDate':'2024-02-29', 'exercise_goal':'60', 'exercise_completed':'40', 'nutrition_goal':'2000',  'nutrition_completed':'800', 'water_goal':'400', 'water_completed':'100','score':'5'}
  ];

  for (var recordData in recordDatas) {
    final existingrecord = await db.getHabitByName(recordData['RecordDate']!);

    // DateTime? record_Date = DateTime.parse(recordDatas['RecordDate'] as String);

    DateTime? recordDate = DateTime.parse(recordData['RecordDate'] as String);

    if (existingrecord == null) {
      await db.addDailyRecord(DailyRecordsCompanion(
        recordDate: drift.Value(recordDate),
        exerciseGoal: drift.Value(int.parse(recordData['exercise_goal']!)),
        exerciseCompleted: drift.Value(int.parse(recordData['exercise_completed']!)),
        nutritionGoal: drift.Value(int.parse(recordData['nutrition_goal']!)),
        nutritionCompleted: drift.Value(int.parse(recordData['nutrition_completed']!)),
        waterGoal: drift.Value(int.parse(recordData['water_goal']!)),
        waterCompleted: drift.Value(int.parse(recordData['water_completed']!)),
        // score: drift.Value(double.parse(recordData['score']!)),
        score: drift.Value(int.parse(recordData['score']!)),

      ));
    }
  }
}


