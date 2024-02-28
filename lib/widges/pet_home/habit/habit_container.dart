import 'habit.dart';
import 'addhabit.dart';
import 'package:flutter/material.dart';
import 'package:untitled/db/DailyRecordDB/dailyrecord_db_manager.dart';


/// 习惯打卡板块
class MultiRowBlock extends StatefulWidget {
  final int quantity;
  final double section_width;

  const MultiRowBlock({
    Key? key,
    required this.quantity,
    required this.section_width,
  }) : super(key: key);

  @override
  _MultiRowBlockState createState() => _MultiRowBlockState();
}

class _MultiRowBlockState extends State<MultiRowBlock> {
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
    mediaWidth = widget.section_width;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 题目
          _buildHeader(),
          /// 几排
          _buildContentContainer(),
          /// 底部添加新习惯button
          Center(
            child: Container(
                width:widget.section_width*0.8,
                child:ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddHabit()), // 导航到 DailyPage 页面
                  );
                },
                  style: ElevatedButton.styleFrom(
                    // 设置按钮的外观样式
                    primary: Colors.orange, // 设置按钮的背景颜色
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // 设置按钮的形状为圆角矩形
                  ),
                  child:const Text('添加新习惯',
                    style: TextStyle(
                      color: Colors.white, // 设置文本颜色为白色
                      fontSize: 18,
                      letterSpacing: 3,
                      fontFamily: 'ZHUOKAI',
                    ),),
                )
            ),
          ),

        ]
    );
  }
  /// 习惯打卡板块的header
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          // color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: widget.section_width*0.05), // 设置左边距为10
          child: const Text(
            '习惯打卡',
            style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'ZHUOKAI',
            ),
          ),
        ),
        SizedBox(width: widget.section_width*0.1,),
        Image.asset('assets/image/habit.png',
          width: widget.section_width*0.45, // 设置宽度
          height: widget.section_width*0.45,
        ), // 替换为实际图片路径
      ],
    );
  }


  /// 几排
  Widget _buildContentContainer() {

    List<Widget> rows = [];

    for(int i=0; i<habits.length;i++){
      final habit = habits[i];
      rows.add(
        ContentRow(subtitle: habit.habitName ?? '吃鱼油', identifier: false)
      );
      rows.add(const SizedBox(height: 10,));
    }
/*
    for (int i = 0; i < 2; i++) {
      if(i%2==0){
        rows.add(
          ContentRow(
            subtitle: '散步',
            identifier: false,
          ),
        );
      }else {
        rows.add(
          ContentRow(
            subtitle: '吃鱼油',
            identifier: false,
          ),
        );
      }
      rows.add(const SizedBox(height: 10,));
    }*/

    // return Expanded(
    //   child: ListView.builder(
    //     itemCount: habits.length,
    //     itemBuilder: (context, index) {
    //       final habit = habits[index];
    //       return ListTile(
    //         ContentRow
    //       );
    //     },
    //   ),
    // );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.section_width * 0.05), // 设置左边距为10
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows,
      ),
    );
  }
}



/// 一周习惯完成情况 一级界面的横排
class ContainerWithWeekGridView extends StatelessWidget {
  final double width;
  final double height;
  final List<bool> identifier;

  const ContainerWithWeekGridView({super.key, required this.width, required this.height, required this.identifier}); // 使用List<bool>来表示identifier



  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black54,
      // height: height,
      // width: width,
      // 不用设置Edge——已经在一级界面设置了divider
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// 第一排
          Container(
            height:25,
            // fontsize:18 对应的实际line-height是24 设置为25此处
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 左侧标题
                Text(
                  '一周习惯完成情况',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ZHUOKAI',
                      color: Colors.black87
                  ),
                ),
                /* // 右侧箭头
                GestureDetector(
                  onTap: () {
                    // 在这里添加跳转逻辑
                  },
                  child: const Row(
                    children: [
                      Text(
                        '去记录',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
          SizedBox(height: 4), // 添加间距
          // 第二排调用显示 WeekGridView
          /// 第二排
          WeekGridView(
            width: width / 7, // 将每个正方形的宽度设为总宽度的1/7
            height: height - 34,
            identifier: [false,false,true,true,true,false,true],

          ),
        ],
      ),
    );
  }
}