
import 'package:flutter/material.dart';

import '../../config/constant_colors.dart';

class MainButton extends StatelessWidget {
  String text;
  Color color;
  IconData? iconData;
  Function()? onPressed;
 MainButton({
   this.text="LOGIN",
   this.iconData,
   this.onPressed,
   this.color=AppColors.PRIMARYCOLOR
});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: MaterialButton(
        onPressed:onPressed,
        height: 50,
        child:MainButtonShape(text: text,
        color: color,
        iconData: iconData,

        )
      ),
    );
  }
}

class MainButtonShape extends StatelessWidget {

  String text;
  Color color;
  IconData? iconData;

  MainButtonShape({
    this.text="LOGIN",
    this.iconData,

    this.color=AppColors.PRIMARYCOLOR
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:  [
        Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
        const  SizedBox(
          width: 5,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        )
      ],
    );
  }
}

