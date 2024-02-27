import 'package:flutter/material.dart';
import 'addhabit.dart';
late double mediaWidth;

class ContainerWithWeekGridView extends StatelessWidget {
  final double width;
  final double height;

  const ContainerWithWeekGridView({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

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
          ),
        ],
      ),
    );
  }
}
/// 星期几 + 正方形板块 一级界面的长条
class WeekGridView extends StatelessWidget {
  final double width;
  final double height;

  const WeekGridView({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 1; i <= 7; i++)
          Expanded(
            child: Container(
              // color: i % 2 == 0 ? Colors.grey[200] : Colors.white, // 设置背景颜色，根据奇偶数切换
              // color: Colors.orange,
              child: DaySquare(
                width: width,
                height: height,
                dayOfWeek: '$i',
                identifier: i,
              ),
            ),
          ),
      ],
    );
  }
}

// DaySquare 的定义
class DaySquare extends StatelessWidget {
  final double width;
  final double height;
  final String dayOfWeek;
  final int identifier;

  const DaySquare({
    Key? key,
    required this.width,
    required this.height,
    required this.dayOfWeek,
    required this.identifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double edgeLength1;
    if(height-12<width) {edgeLength1 = (height-12)*0.8;}else{edgeLength1=width*0.8;}
    double edgeLength2 = edgeLength1 *0.9;
    return Column(
      children: [
        // 星期几
        Container(
          alignment: Alignment.center,
          child: Text(
            /// 显示周几的部分
            dayOfWeek,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
        // 正方形
        SquareBlock(
          width: edgeLength1,
          height: edgeLength1,
          // height: height - 12, // 减去上方星期几文字和间距的高度
          identifier: identifier,
          squareSize: edgeLength2,
        ),
      ],
    );
  }
}

/// 将习惯展示栏整合成为一个横排
class SquareBlock extends StatelessWidget {
  final double width;
  final double height;
  final int identifier;
  final double squareSize; // 正方形的大小

  const SquareBlock({
    Key? key,
    required this.width,
    required this.height,
    required this.identifier,
    required this.squareSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // 四周圆角
        color: Colors.orange[50], // 根据 identifier 判断颜色
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 阴影颜色
            spreadRadius: 1, // 阴影扩散程度
            blurRadius: 2, // 阴影模糊程度
            offset: Offset(0, 1), // 阴影偏移量
          ),
        ],
      ),
      child: identifier == 1 // 根据 identifier 判断显示正方形还是三角形
          ?  Center(
        child: fulSquare(
          size: squareSize,
        ),
      )
          : Center(
        child: Container(
          width: squareSize,
          height: squareSize,
          decoration: BoxDecoration(
            // color: Colors.orange, // 三角形颜色
          ),
          child: CustomPaint(
            painter: TrianglePainter(),
          ),
        ),
      ),
    );
  }
}

/// 完成了习惯调用fulsquare 正方形
class fulSquare extends StatelessWidget {
  final double size;

  const fulSquare({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
/// 未完成习惯调用显示三角形
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange // 三角形颜色
      ..style = PaintingStyle.fill;
    double w = size.width;
    double h =size.height;
    Path path = Path();
    path.moveTo(w*0.1, h ); // 移动到左下角
    path.arcToPoint(
      Offset(w*0.04 , h * 0.9), // 圆弧起点
      radius: Radius.circular(w * 0.08), // 圆弧半径
    );
    path.lineTo(w*0.04,h *0.1); // 左上角
    path.arcToPoint(
      Offset(w * 0.14, h * 0.06), // 圆弧起点
      radius: Radius.circular(w * 0.08), // 圆弧半径
    );
    path.lineTo(w*0.94, h*0.9); // 右下角
    path.arcToPoint(
      Offset(w * 0.88, h ), // 圆弧起点
      radius: Radius.circular(w * 0.1), // 圆弧半径
    );
    path.close(); // 封闭路径

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



/// 习惯打卡板块


class MultiRowBlock extends StatelessWidget {
  final int quantity;
  final double section_width;
  // final double height;

  const MultiRowBlock({Key? key, required this.quantity,required this.section_width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaWidth = section_width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildContentContainer(),
        /// 底部添加新习惯button
        Center(
          child: Container(
          width:section_width*0.8,
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
          margin: EdgeInsets.symmetric(horizontal: section_width*0.05), // 设置左边距为10
          child: const Text(
            '习惯打卡',
            style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
              fontFamily: 'ZHUOKAI',
            ),
          ),
        ),
        SizedBox(width: section_width*0.1,),
        Image.asset('assets/image/habit.png',
          width: section_width*0.45, // 设置宽度
          height: section_width*0.45,
        ), // 替换为实际图片路径
      ],
    );
  }

  Widget _buildContentContainer() {
    List<Widget> rows = [];
    for (int i = 0; i < quantity; i++) {
      if(i%2==0){
        rows.add(
          ContentRow(
            subtitle: '散步',
            identifier: i + 1,
          ),
        );
      }else {
        rows.add(
          ContentRow(
            subtitle: '吃鱼油',
            identifier: i + 1,
          ),
        );
      }
      rows.add(const SizedBox(height: 10,));
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: section_width * 0.05), // 设置左边距为10
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows,
      ),
    );
  }
}

/// 每一行习惯
class ContentRow extends StatelessWidget {
  final String subtitle;
  final int identifier;

  const ContentRow({
    Key? key,
    required this.subtitle,
    required this.identifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: mediaWidth*0.2,
          child: Text(subtitle,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'ZHUOKAI',
            ),
          ),
        ),
        // Text(subtitle),
        SizedBox(width: mediaWidth*0.02),

        SquareBlock(
          width: mediaWidth*0.15, // 宽度
          height: mediaWidth*0.15, // 高度
          identifier: identifier == 0 ? 1 : 0, // 根据索引设置标识符
          squareSize: mediaWidth*0.14, // 正方形大小
        ),
        SizedBox(width: mediaWidth*0.1),
        Container(
          width: mediaWidth*0.4,
          child: ElevatedButton(
            onPressed: () {
              // 按钮点击事件
            },
            style: ElevatedButton.styleFrom(
              // 设置按钮的外观样式
              // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 设置按钮内边距
              primary: Colors.orange, // 设置按钮的背景颜色
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // 设置按钮的形状为圆角矩形
            ),
            child: const Text('今日已完成',
              style: TextStyle(
                color: Colors.white, // 设置文本颜色为白色
                fontSize: 18,
                fontFamily: 'ZHUOKAI',
              ),
            ), // 按钮文本
          ),
        ),
      ],
    );
  }
}

