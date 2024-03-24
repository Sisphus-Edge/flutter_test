
import 'package:flutter/material.dart';
import 'package:untitled/db/DailyRecordDB/dailyrecord_db_manager.dart';
import 'package:drift/drift.dart' as drift;

// Define a custom Form widget.
class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}


class _AddHabitState extends State<AddHabit> {

  final nameController = TextEditingController();
  String _habitName = '';
  List<bool> _radioValues = List.generate(7, (index) => false);
  final List<String> _weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];


  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    super.dispose();
  }

  void _saveHabitName(String name) {
    setState(() {
      _habitName = name;
    });
  }

  void _saveSelectedDays(List<bool> values) {
    setState(() {
      _radioValues.clear();
      _radioValues.addAll(values);
    });
  }

  void _onSavePressed() {
    // Save habit name and selected radio buttons
    _saveHabitName(nameController.text);
    _saveSelectedDays(_radioValues);
    // Perform any other necessary actions, such as navigating back



    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '新习惯',
          style: TextStyle(
            fontFamily: "ZHUOKAI",
          ),
        ),
      ),
      body: Container(
        color: const Color(0XFFFFF3E9),
        width: screenWidth,
        child: Column(
          children: [
            SizedBox(height: screenHeight*0.02,),
            inputHabitName(screenWidth*0.9,screenHeight*0.2),
            SizedBox(height: screenHeight*0.02,),
            inputFrequency(screenWidth*0.9, screenHeight*0.2),
            SizedBox(height: screenHeight*0.02,),
            FloatingActionButton(
              onPressed: () async{
                // _saveHabitName(nameController.text);
                // _saveSelectedDays(_radioValues);
                String habitName = nameController.text;

                DateTime now = DateTime.now();
                DateTime combinedDateTime = DateTime(now.year, now.month, now.day);

                final dbManager = DailyRecordDBManager();
                final habit = HabitsCompanion(
                  habitName: drift.Value(habitName),
                  startDate: drift.Value(combinedDateTime),
                  monday: drift.Value(_radioValues[0]),
                  tuesday: drift.Value(_radioValues[1]),
                  wednesday: drift.Value(_radioValues[2]),
                  thursday: drift.Value(_radioValues[3]),
                  friday: drift.Value(_radioValues[4]),
                  saturday: drift.Value(_radioValues[5]),
                  sunday: drift.Value(_radioValues[6])
                );
                
                await dbManager.addHabit(habit).then((value) => Navigator.of(context).pop());
                // Navigator.of(context).pop();

              },
              backgroundColor: Colors.orange, // 按钮的背景颜色
              child: const Icon(Icons.check, size: 40.0), // 在按钮中心放置一个勾号图标
              shape: const CircleBorder(),
            ),


          ],
        ),
      ),
    );
  }

  Widget inputHabitName(double width,double height){
    return Container(
      width: width,
      height: height,
      // color: Colors.grey,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,

      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          buildTitle('习惯名称'),
          const SizedBox(height: 20),
          // TitleInputField(controller: nameController,),
          buildInput(nameController, height*0.5, width*0.9)

        ],
      ),
    );
  }

  Widget inputFrequency(double width,double height){
    return Container(
      width: width,
      height: height,
      // color: Colors.grey,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,

      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          buildTitle('选择频率'),
          const SizedBox(height: 20),
          // TitleInputField(controller: nameController,),
          // SevenRadioButtons(width: width,height:height),
          buildSevenButton(width),
        ],
      ),
    );
  }

  Widget buildTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          title,
          style: const TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 20.0,
            fontFamily: 'ZHUOKAI',
            color: Colors.black87
          ),
        ),
      ),
    );
  }

  Widget buildInput(TextEditingController controller,double height,double width) {
    return Container(
      height: height, // 设置输入框的高度
      width: width,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey), // 设置横线的样式
        // color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0), // 设置圆角
      ),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.drive_file_rename_outline),
          hintText: '请输入习惯名称',
            /// 编辑时候的样式
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Color(0XFFFFF3E9),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              ///设置边框四个角的弧度
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Colors.orange,
                width: 2.0,
              ),
            ),


          // border: OutlineInputBorder(),
        ),
      ),

    );
  }

  @override
  Widget buildSevenButton(double width) {
    double circleRadius = width *0.09;
    double circleSpan = width *0.01;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        7,
            (index) => GestureDetector(
          onTap: () {
            setState(() {
              _radioValues[index] = !_radioValues[index];
            });
          },
          child: Column(
            children: [
              Text(
                _weekdays[index], // 使用星期几名称作为标题
                style: const TextStyle(
                    fontSize: 14.0,
                    fontFamily: "ZHUOKAI"
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8,),
              Container(
                padding: EdgeInsets.all(circleSpan),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _radioValues[index] ? Colors.orange : Colors.grey,
                    width: 2.0,
                  ),
                ),
                child: _radioValues[index]
                    ? Container(
                  width: circleRadius,
                  height: circleRadius,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                )
                    : Container(
                  width: circleRadius,
                  height: circleRadius,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/// 选择频率复选框 ——一排7个
class SevenRadioButtons extends StatefulWidget {
  final double width;
  final double height;

  const SevenRadioButtons({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _SevenRadioButtonsState createState() => _SevenRadioButtonsState();
}

class _SevenRadioButtonsState extends State<SevenRadioButtons> {
  final List<bool> _radioValues = List.generate(7, (index) => false);
  final List<String> _weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

  @override
  Widget build(BuildContext context) {
    double circleRadius = widget.width *0.09;
    double circleSpan = widget.width *0.01;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        7,
            (index) => GestureDetector(
          onTap: () {
            setState(() {
              _radioValues[index] = !_radioValues[index];
            });
          },
          child: Column(
            children: [
              Text(
                _weekdays[index], // 使用星期几名称作为标题
                style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: "ZHUOKAI"
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8,),
              Container(
                padding: EdgeInsets.all(circleSpan),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _radioValues[index] ? Colors.orange : Colors.grey,
                    width: 2.0,
                  ),
                ),
                child: _radioValues[index]
                    ? Container(
                  width: circleRadius,
                  height: circleRadius,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                )
                    : Container(
                  width: circleRadius,
                  height: circleRadius,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}