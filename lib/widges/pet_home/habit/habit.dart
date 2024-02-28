import 'package:flutter/material.dart';

late double mediaWidth;

/// 星期几 + 正方形板块 一级界面的长条
class WeekGridView extends StatelessWidget {
  final double width;
  final double height;
  final List<bool> identifier; // 使用List<bool>来表示identifier

  const WeekGridView({
    Key? key,
    required this.width,
    required this.height,
    required this.identifier, // 接收List<bool>类型的identifier
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 7; i++) // 修改循环条件
          Expanded(
            child: Container(
              child: DaySquare(
                width: width,
                height: height,
                dayOfWeek: '${i + 1}', // 将i转换为星期的字符串表示形式
                identifier: identifier[i], // 使用identifier数组中的值
              ),
            ),
          ),
      ],
    );
  }
}
/// 一个正方形板块 = 日期+正方形
class DaySquare extends StatelessWidget {
  final double width;
  final double height;
  final String dayOfWeek;
  final bool identifier;

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

/// 正方形板块  背景板 + 正方形 or 三角形
/// identifier为 1 则显示完成，为正方形
class SquareBlock extends StatelessWidget {
  final double width;
  final double height;
  final bool identifier;
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
      /// 这一部分是背景板
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
      /// 下面这个是
      child: identifier == true // 根据 identifier 判断显示正方形还是三角形
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
          ),
          child: CustomPaint(
            painter: TrianglePainter(),
          ),
        ),
      ),
    );
  }
}

/// 显示正方形
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

class ContentRow extends StatelessWidget {
  final String subtitle;
  final bool identifier;
  // final VoidCallback onPressed; // 新添加的回调函数参数

  const ContentRow({
    Key? key,
    required this.subtitle,
    required this.identifier,
    // required this.onPressed, // 更新构造函数
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: mediaWidth * 0.2,
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'ZHUOKAI',
            ),
          ),
        ),
        SizedBox(width: mediaWidth * 0.02),
        SquareBlock(
          width: mediaWidth * 0.15,
          height: mediaWidth * 0.15,
          identifier: identifier,
          squareSize: mediaWidth * 0.14,
        ),
        SizedBox(width: mediaWidth * 0.1),
        Container(
          width: mediaWidth * 0.4,
          child: ElevatedButton(
            onPressed: (){}, // 将传入的回调函数作为按钮点击事件
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              '今日已完成',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'ZHUOKAI',
              ),
            ),
          ),
        ),
      ],
    );
  }
}


/*
/// 每一行习惯
class ContentRow extends StatelessWidget {
  final String subtitle;
  final bool identifier;


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
            style: const TextStyle(
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
          identifier: identifier == true, // 根据索引设置标识符
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
*/

