import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:untitled/states/page_transformer_login_data.dart';
import 'package:untitled/widges/intro_page/page_transformer.dart';
import 'intro_page_item.dart';

class IntroPageView extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver){
              if (visibilityResolver == null) {
                visibilityResolver = PageVisibilityResolver(
                  // 根据需要设置 PageMetrics 的属性
                  metrics: PageMetrics(
                    minScrollExtent: 0.0,
                    maxScrollExtent: 1000.0,
                    pixels: 500.0,
                    viewportDimension: 200.0,
                    axisDirection: AxisDirection.down,
                    viewportFraction: 0.8,
                    devicePixelRatio: 1.0,
                  ),
                  viewPortFraction: 0.8,
                );
              }
              return PageView.builder(
                controller: PageController(viewportFraction: 0.85),
                itemCount: sampleItems.length,
                itemBuilder: (context,index){
                  final item = sampleItems[index];
                  final pageVisibility =
                      visibilityResolver.resolvePageVisibility(index);
                  return IntroPageItem(
                      item: item, pageVisibility: pageVisibility,);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}