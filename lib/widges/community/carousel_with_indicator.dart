import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:untitled/db/PostDB/post_db_manager.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<Post> posts;

  const CarouselWithIndicator({Key? key, required this.posts}) : super(key: key);

  @override
  State<CarouselWithIndicator> createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.posts.map((post) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      children: [
                        Image.asset(
                            post.imagePath ?? 'assets/image/login/2.png', // 使用 ?? 提供一个默认值
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            color: Colors.black.withOpacity(0.5),
                            child: Text(
                              post.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.posts.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => {}, // 可以添加点击小点点切换轮播图的逻辑
              child: Container(
                width: _current == entry.key ? 10.0 : 8.0,
                height: _current == entry.key ? 10.0 : 8.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key ? Colors.blue : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
