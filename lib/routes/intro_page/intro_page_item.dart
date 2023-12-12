import 'package:flutter/material.dart';
import 'package:flutter_page_view_indicator/flutter_page_view_indicator.dart';
import 'page_transformer.dart';
import 'package:untitled/states/page_transformer_login_data.dart';


class IntroPageItem extends StatelessWidget {

  IntroPageItem({
    required this.item,required this.pageVisibility});

  late final IntroItem item;
  late final PageVisibility pageVisibility;

/// 应用文本效果 接受的参数控制文本在页面上的水平移动量
  Widget _applyTextEffects({
    required double translationFactor,
    required Widget child,
}){
    final double xTranslation = pageVisibility.pagePosition * translationFactor;
    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
}

/// 创建文本容器
  _buildTextContainer(BuildContext context){
    var textTheme = Theme.of(context).textTheme;
    var categoryText = _applyTextEffects(
        translationFactor: 300.0,
        child: Text(
          item.category,
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            fontSize: 14.0,
          ),
          textAlign: TextAlign.center,
        ),
    );
    var titleText = _applyTextEffects(
        translationFactor: 200.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            item.title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
        ),
    );
    return Positioned(
      bottom: 56.0,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          categoryText,
          titleText,
        ],
      ),
    );
  }


  /// 组件的构建，包含图片，以及imageOverlayGradient渐变效果器
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // int image_count;
    var image = Image.asset(
      item.imageUrl,
      fit: BoxFit.cover,
      alignment: FractionalOffset(
        0.5 + (pageVisibility.pagePosition / 3),
        0.5,
      ),
    );

    /// 设置渐变色
    var imageOverlayGradient = const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
              colors: [
                // Color(0xFF000000),
                Colors.black87,
                // Color(0xFFB6ACC5),
                Color(0x00000000),
              ]
          ),
        )
    );


    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 8.0,
        ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9), // 设置阴影颜色和透明度
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(2, 4), // 设置阴影偏移量
            ),
          ],
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              image,
              imageOverlayGradient,
              _buildTextContainer(context),
              // Positioned(
              //   bottom: 16.0,
              //   left: 0,
              //   right: 0,
              //   child: PageViewIndicator(
              //       length: 3,
              //       currentIndex: item,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }



}
