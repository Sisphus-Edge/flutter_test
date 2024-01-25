import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;

  const RatingStars({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    double halfStarThreshold = 0.5;
    double starSize = 16.0; // 设置星星的大小

    for (int i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.add(Icon(Icons.star, color: Colors.red, size: starSize));
      } else if (i == fullStars && rating % 1 >= halfStarThreshold) {
        stars.add(Icon(Icons.star_half, color: Colors.red, size: starSize));
      } else {
        stars.add(Icon(Icons.star_border, color: Colors.grey, size: starSize));
      }
    }

    return Row(children: stars);
  }
}
