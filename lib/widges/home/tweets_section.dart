import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';


class TCardSecton extends StatefulWidget {
  final double section_width;
  final double section_height;
  TCardSecton({super.key, required this.section_width, required this.section_height});

  @override
  _TCardSectonState createState() => _TCardSectonState();

}

class _TCardSectonState extends State<TCardSecton>  with TickerProviderStateMixin{


  Alignment _frontCardAlignment = Alignment(0.0, -0.5);
  // 保存最前面卡片的旋转角度
  double _frontCardRotation = 0.0;

  late double card_width;
  late double card_height;



// 卡片回弹动画
  late Animation<Alignment> _reboundAnimation;
  // 卡片回弹动画控制器
  late AnimationController _reboundController;

  // 卡片位置变换动画控制器
  late AnimationController _cardChangeController;

  // 改变位置的动画
  void _runChangeOrderAnimation() {
    _cardChangeController.reset();
    _cardChangeController.forward();
  }

// 卡片回弹的动画
  void _runReboundAnimation(Offset pixelsPerSecond, Size size) {
    // 创建动画值
    _reboundAnimation = _reboundController.drive(
      AlignmentTween(
        // 起始值是卡片当前位置，最终值是卡片的默认位置
        begin: _frontCardAlignment,
        end: Alignment(0.0, -0.5),
      ),
    );
    // 计算卡片运动速度
    final double unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final double unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;
    // 创建弹簧模拟的定义
    const spring = SpringDescription(mass: 30, stiffness: 1, damping: 1);
    // 创建弹簧模拟
    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);
    // 根据给定的模拟运行动画
    _reboundController.animateWith(simulation);
    // 重置旋转值
    _frontCardRotation = 0.0;
    setState(() {});
  }

// 卡片横轴距离限制
  final double limit = 1.0;

  //  前面的卡片，使用 Align 定位
  Widget _frontCard(BoxConstraints constraints) {
    // 判断动画是否在运行
    bool forward = _cardChangeController.status == AnimationStatus.forward;

    // 使用 Transform.rotate 旋转卡片
    Widget rotate = Transform.rotate(
      angle: (pi / 180.0) * _frontCardRotation,
      // 使用 SizedBox 确定卡片尺寸
      child: SizedBox.fromSize(
        size: CardSizes.front(constraints),
        child: Container(
          // color: Colors.grey,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/test/1.png'),
              fit: BoxFit.cover, // 图片填充方式
            ),
          ),
        ),
      ),
    );

    // 在动画运行时使用动画值
    if (forward) {
      return Align(
        alignment: CardAnimations.frontCardDisappearAnimation(
          _cardChangeController,
          _frontCardAlignment,
        ).value,
        child: rotate,
      );
    }

    // 否则使用默认值
    return Align(
      alignment: _frontCardAlignment,
      child: rotate,
    );
  }

  // 中间的卡片，使用 Align 定位
  Widget _middleCard(BoxConstraints constraints) {
    // 判断动画是否在运行
    bool forward = _cardChangeController.status == AnimationStatus.forward;
    Widget child = Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/test/2.png'),
            fit: BoxFit.cover, // 图片填充方式
          ))
    );

    // 在动画运行时使用动画值
    if (forward) {
      return Align(
        alignment: CardAnimations.middleCardAlignmentAnimation(
          _cardChangeController,
        ).value,
        child: SizedBox.fromSize(
          size: CardAnimations.middleCardSizeAnimation(
            _cardChangeController,
            constraints,
          ).value,
          child: child,
        ),
      );
    }

    // 否则使用默认值
    return Align(
      alignment: CardAlignments.middle,
      child: SizedBox.fromSize(
        size: CardSizes.middle(constraints),
        child: child,
      ),
    );
  }

  // 后面的卡片，使用 Align 定位
  Widget _backCard(BoxConstraints constraints) {
    // 判断动画是否在运行
    bool forward = _cardChangeController.status == AnimationStatus.forward;
    Widget child = Container(
      color: Colors.grey,
       );

    // 在动画运行时使用动画值
    if (forward) {
      return Align(
        alignment: CardAnimations.backCardAlignmentAnimation(
          _cardChangeController,
        ).value,
        child: SizedBox.fromSize(
          size: CardAnimations.backCardSizeAnimation(
            _cardChangeController,
            constraints,
          ).value,
          child: child,
        ),
      );
    }

    // 否则使用默认值
    return Align(
      alignment: CardAlignments.back,
      child: SizedBox.fromSize(
        size: CardSizes.back(constraints),
        child: child,
      ),
    );
  }




  @override
  void initState() {
    super.initState();
    // 初始化回弹的动画控制器
    _reboundController = AnimationController(vsync: this)
      ..addListener(() {
        setState(() {
          // 动画运行时更新最前面卡片的 alignment 属性
          _frontCardAlignment = _reboundAnimation.value;
        });
      });

    // 初始化卡片换位动画控制器
    _cardChangeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 动画运行结束后重置位置和旋转
          _frontCardRotation = 0.0;
          _frontCardAlignment = CardAlignments.front;
          setState(() {});
        }
      });
  }



  @override
  Widget build(BuildContext context) {
    // initState();

    card_width = widget.section_width;
    card_height = widget.section_height ;
    return Center(
      child: SizedBox(
        width: card_width,
        height: card_height,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // 使用 LayoutBuilder 获取容器的尺寸，传个子项计算卡片尺寸
            Size size = MediaQuery.of(context).size;
            double speed = 10.0;

            return Stack(
              children: [
                // 后面的子项会显示在上面，所以前面的卡片放在最后
                _backCard(constraints),
                _middleCard(constraints),
                _frontCard(constraints),
                // 使用一个占满父元素的 GestureDetector 监听手指移动
                SizedBox.expand(
                  child: GestureDetector(
                    onPanDown: (DragDownDetails details) {},
                    onPanUpdate: (DragUpdateDetails details) {
                      // 手指移动就更新最前面卡片的 alignment 属性
                      _frontCardAlignment += Alignment(
                        details.delta.dx / (size.width / 2) * speed,
                        details.delta.dy / (size.height / 2) * speed,
                      );
                      // 设置最前面卡片的旋转角度
                      _frontCardRotation = _frontCardAlignment.x;
                      // setState 更新界面
                      setState(() {});
                    },
                    onPanEnd: (DragEndDetails details) {
                      if (_frontCardAlignment.x > limit || _frontCardAlignment.x < -limit)
                      {
                        _runChangeOrderAnimation();
                      }
                      else{
                        _runReboundAnimation(
                          details.velocity.pixelsPerSecond,
                          size,
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


/// 卡片尺寸
class CardSizes {
  static Size front(BoxConstraints constraints) {
    return Size(constraints.maxWidth * 0.9, constraints.maxHeight * 0.9);
  }

  static Size middle(BoxConstraints constraints) {
    return Size(constraints.maxWidth * 0.85, constraints.maxHeight * 0.9);
  }

  static Size back(BoxConstraints constraints) {
    return Size(constraints.maxWidth * 0.8, constraints.maxHeight * .9);
  }
}


/// 卡片位置
class CardAlignments {
  static Alignment front = Alignment(0.0, -0.5);
  static Alignment middle = Alignment(0.0, 0.0);
  static Alignment back = Alignment(0.0, 0.5);
}
/// 卡片运动动画
class CardAnimations {
  /// 最前面卡片的消失动画值
  static Animation<Alignment> frontCardDisappearAnimation(
      AnimationController parent,
      Alignment beginAlignment,
      ) {
    return AlignmentTween(
      begin: beginAlignment,
      end: Alignment(
        beginAlignment.x > 0
            ? beginAlignment.x + 30.0
            : beginAlignment.x - 30.0,
        0.0,
      ),
    ).animate(
      CurvedAnimation(
        parent: parent,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
  }

  /// 中间卡片位置变换动画值
  static Animation<Alignment> middleCardAlignmentAnimation(
      AnimationController parent,
      ) {
    return AlignmentTween(
      begin: CardAlignments.middle,
      end: CardAlignments.front,
    ).animate(
      CurvedAnimation(
        parent: parent,
        curve: Interval(0.2, 0.5, curve: Curves.easeIn),
      ),
    );
  }

  /// 中间卡片尺寸变换动画值
  static Animation<Size?> middleCardSizeAnimation(
      AnimationController parent,
      BoxConstraints constraints,
      ) {
    return SizeTween(
      begin: CardSizes.middle(constraints),
      end: CardSizes.front(constraints),
    ).animate(
      CurvedAnimation(
        parent: parent,
        curve: Interval(0.2, 0.5, curve: Curves.easeIn),
      ),
    );
  }

  /// 最后面卡片位置变换动画值
  static Animation<Alignment> backCardAlignmentAnimation(
      AnimationController parent,
      ) {
    return AlignmentTween(
      begin: CardAlignments.back,
      end: CardAlignments.middle,
    ).animate(
      CurvedAnimation(
        parent: parent,
        curve: Interval(0.4, 0.7, curve: Curves.easeIn),
      ),
    );
  }

  /// 最后面卡片尺寸变换动画值
  static Animation<Size?> backCardSizeAnimation(
      AnimationController parent,
      BoxConstraints constraints,
      ) {
    return SizeTween(
      begin: CardSizes.back(constraints),
      end: CardSizes.middle(constraints),
    ).animate(
      CurvedAnimation(
        parent: parent,
        curve: Interval(0.4, 0.7, curve: Curves.easeIn),
      ),
    );
  }


}