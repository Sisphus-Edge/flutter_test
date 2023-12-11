import 'package:flutter/material.dart';
import 'page_transformer.dart';
import 'package:untitled/states/page_transformer_login_data.dart';


class IntroPageItem extends StatelessWidget {

  IntroPageItem({
    required this.item,required this.pageVisibility});

  late final IntroItem item;
  late final PageVisibility pageVisibility;


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


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var image = Image.asset(
      item.imageUrl,
      fit: BoxFit.cover,
      alignment: FractionalOffset(
        0.5 + (pageVisibility.pagePosition / 3),
        0.5,
      ),
    );

    var imageOverlayGradient = const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
              colors: [
                Color(0xFF000000),
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
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            image,
            imageOverlayGradient,
            _buildTextContainer(context),
          ],
        ),
      ),
    );
  }



}
