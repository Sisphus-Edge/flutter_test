import 'package:flutter/material.dart';

double globalItemHeight = 100; // 全局变量用于itemheight
// 第二排的height直接在DoubleLayerExpanded中实现
int _gobalItemIndex = 0;


class MyGridView extends StatefulWidget {
  final double width;
  final double height;
  final bool state;
  /// state为true表示一级界面  state为false表示为每日记录
  const MyGridView({Key? key, required this.width, required this.height,required this.state})
      : super(key: key);

  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  // 用于控制第二排元素的状态列表
  List<bool> _secondRowItemsStatus = [false, false, false];

  // 用于记录第一排哪个元素被点击了
  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    final itemWidth = widget.width / 3;
    final itemHeight1 = widget.height / 5 * 2;
    globalItemHeight = widget.height / 5 * 3;

    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFEAEAEA), // 整个 MyGridView 的背景色为灰色
        borderRadius: BorderRadius.circular(10), // 添加圆角
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 外部阴影颜色和透明度
            spreadRadius: 2, // 阴影扩散半径
            blurRadius: 5, // 阴影模糊半径
            offset: Offset(0, 2), // 阴影偏移量，控制阴影位置
          ),
        ],
      ),
      child: Column(
        children: [
          // 第一排
          Row(
            children: [
              const SizedBox(width: 15), // 添加透明的水平分隔空间
              Expanded(
                child: GestureDetector(
                   onTap: () {
                  setState(() {
                    _selectedItemIndex = 0;
                    _gobalItemIndex = 0;
                    _secondRowItemsStatus = [true, false, false];
                  });
                },
                  child: Container(
                    // 此处container的大小也是button背景版的大小
                    height: itemHeight1*0.7,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15), // 设置圆角
                      color: _selectedItemIndex == 0 ? Color(0XFF726EF0) : Colors.transparent,
                        boxShadow:[
                          BoxShadow(
                            color: _selectedItemIndex == 0 ? Colors.grey.withOpacity(0.5) : Colors.transparent, // 外部阴影颜色和透明度
                            blurRadius: 2, // 阴影模糊半径
                            offset: Offset(0, 2), // 阴影偏移量，控制阴影位置
                          ),
                        ],
                    ),

                    child: Center(
                      child: Text('锻炼',style: TextStyle(
                        fontFamily: 'ZHUOKAI',
                        letterSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: _selectedItemIndex == 0 ? Colors.white : Colors.black,
                      ),),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15), // 添加透明的水平分隔空间
              // 摄入营养部分
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedItemIndex = 1;
                      _secondRowItemsStatus = [false, true, false];
                    });
                  },
                  child: Container(
                    // 此处container的大小也是button背景版的大小
                    height: itemHeight1*0.7,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15), // 设置圆角
                      color: _selectedItemIndex == 1 ? Color(0XFF726EF0) : Colors.transparent,
                      boxShadow:[
                        BoxShadow(
                          color: _selectedItemIndex == 1 ? Colors.grey.withOpacity(0.5) : Colors.transparent, // 外部阴影颜色和透明度
                          blurRadius: 2, // 阴影模糊半径
                          offset: Offset(0, 2), // 阴影偏移量，控制阴影位置
                        ),
                      ],
                    ),

                    child: Center(
                      child: Text('摄入营养',style: TextStyle(
                        fontFamily: 'ZHUOKAI',
                        letterSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: _selectedItemIndex == 1 ? Colors.white : Colors.black,
                      ),),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15), // 添加透明的水平分隔空间
              // 摄入水分部分
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedItemIndex = 2;
                      _secondRowItemsStatus = [false, false, true];
                    });
                  },
                  child: Container(
                    // 此处container的大小也是button背景版的大小
                    height: itemHeight1*0.7,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15), // 设置圆角
                      color: _selectedItemIndex == 2 ? Color(0XFF726EF0) : Colors.transparent,
                      boxShadow:[
                        BoxShadow(
                          color: _selectedItemIndex == 2 ? Colors.grey.withOpacity(0.5) : Colors.transparent, // 外部阴影颜色和透明度
                          blurRadius: 2, // 阴影模糊半径
                          offset: Offset(0, 2), // 阴影偏移量，控制阴影位置
                        ),
                      ],
                    ),

                    child: Center(
                      child: Text('摄入水分',style: TextStyle(
                        fontFamily: 'ZHUOKAI',
                        letterSpacing: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: _selectedItemIndex == 2 ? Colors.white : Colors.black,
                      ),),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15), // 添加透明的水平分隔空间

            ],
          ),
          // 添加第一排和第二排之间的分割线
          Divider(color: Colors.white),
          // 第二排
          // Column(
          // CustomRow(identifier: 1, height: globalItemHeight),
          CustomRow(
            identifier: _selectedItemIndex,
          ),
            // Divider(color: Colors.white), // 第二排之间的分割线

        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final int identifier;


  const CustomRow({
    Key? key,
    required this.identifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget row;
    switch (identifier) {
      case 0:
        row = _buildRow(0, 60, 40);
        break;
      case 1:
        row = _buildRow(1, 2000, 1500);
        break;
      case 2:
        row = _buildRow(2, 400, 200);
        break;
      default:
        row = Container(); // 或者返回一个空容器，或者抛出异常，取决于具体需求
    }
    return row;
  }

  Widget _buildRow(int id_Row1, int goal, int bingo) {
    return Row(
      children: [
        DoubleLayerExpanded(id:id_Row1, data:goal, identifier: '目标'),
        Divider(height: globalItemHeight, color: Colors.black), // 添加分割线
        DoubleLayerExpanded(id:id_Row1, data:bingo, identifier: '已完成'),
        Divider(height: globalItemHeight, color: Colors.black), // 添加分割线
        DoubleLayerExpanded(id:id_Row1, data:goal - bingo, identifier: '还需完成'),
      ],
    );
  }
}

class DoubleLayerExpanded extends StatelessWidget {
  final int id;
  final int data;
  final String identifier;

  const DoubleLayerExpanded({
    Key? key,
    required this.id,
    required this.data,
    required this.identifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lowerText = '';

    // 根据不同的 id 设置不同的字
    switch (id) {
      case 0:
        lowerText = 'min';
        break;
      case 1:
        lowerText = 'kcal';
        break;
      case 2:
        lowerText = 'ml';
        break;
      default:
        lowerText = 'min';
    }

    return Expanded(
      flex: 1,
      child: Container(
        height: globalItemHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  height: globalItemHeight *0.4,
                  // color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 6), // 调整垂直方向上的内边距
                  child: Text(
                    '$identifier',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  height: globalItemHeight *0.6,
                  // color: Colors.pink,
                  padding: const EdgeInsets.symmetric(vertical: 6), // 调整垂直方向上的内边距
                  child: Text(
                    '$data $lowerText',
                    style: const TextStyle(fontSize: 18,fontFamily: 'ZCOOL',
                      letterSpacing: 2,wordSpacing: 2,),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
