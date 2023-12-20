import 'package:flutter/material.dart';



class SectionButton extends StatelessWidget {
  final String title;
  final bool isMoreButton;
  final Function()? onTap;

  const SectionButton({
    required this.title,
    required this.isMoreButton,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isMoreButton ? Colors.blueGrey : Colors.blue,
          shape: isMoreButton ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isMoreButton ? null : BorderRadius.circular(15),
        ),
        child: Center(
          child: isMoreButton
              ? const Icon(
            Icons.add,
            color: Colors.white,
          )
              : Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}