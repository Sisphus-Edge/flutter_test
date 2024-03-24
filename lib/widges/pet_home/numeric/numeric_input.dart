import 'package:untitled/db/DailyRecordDB/dailyrecord_db_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

double globalItemHeight = 100; // 全局变量用于itemheight
// 第二排的height直接在DoubleLayerExpanded中实现
int _gobalItemIndex = 0;

class DoubleLayerExpanded extends StatefulWidget {
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
  _DoubleLayerExpandedState createState() => _DoubleLayerExpandedState();
}

class _DoubleLayerExpandedState extends State<DoubleLayerExpanded> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.data.toString());
    _controller.addListener(_updateData);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateData() {
    setState(() {
      // 更新数据
      // widget.data = int.tryParse(_controller.text) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    String lowerText = '';

    // 根据不同的 id 设置不同的字
    switch (widget.id) {
      case 0:
        lowerText = 'min';
        break;
      case 1:
        lowerText = 'k';
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
                  height: globalItemHeight * 0.4,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    '${widget.identifier}',
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
                  height: globalItemHeight * 0.6,
                  padding: const EdgeInsets.only(top: 6),
                  child: TextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixText: ' $lowerText',
                      suffixStyle: const TextStyle(fontSize: 18),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'ZCOOL',
                      letterSpacing: 1,
                      wordSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      // 更新数据
                      _updateData();
                    },
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
/// 第二排显示数值的格式
class DoubleLayerExpandedTrue extends StatelessWidget {
  final int id;
  final int data;
  final String identifier;

  const DoubleLayerExpandedTrue({
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
        lowerText = 'k';
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
                  padding: const EdgeInsets.only(top: 6), // 调整垂直方向上的内边距
                  child: Text(
                    '$data $lowerText',
                    style: const TextStyle(fontSize: 18,fontFamily: 'ZCOOL',
                      letterSpacing: 1,wordSpacing: 1,),
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
