import 'package:flutter/material.dart';

class DrawerComponent extends StatelessWidget {
  Color textColor;
  String text;
  String image;
  double imageWidth;
  double imageHeight;
  double fontSize;
  Function()? onPressed;
  // Function onHover;
  DrawerComponent({
    required this.textColor,
    required this.image,
    required this.text,
    this.imageHeight=30,
    this.imageWidth=30,
    this.fontSize=15,
    required this.onPressed,
    // required this.onHover
  });
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Image.asset(color: textColor,
            image,
            width: imageWidth,
            height: imageHeight,
          ),
          const SizedBox(width: 10,),
          TextButton(
            onPressed: onPressed,
            child: Text(text,
              style: TextStyle(
                color:textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),),
          )
        ],

      ),
    );
  }
}