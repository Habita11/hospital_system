
import 'package:flutter/material.dart';

import '../../config/constant_colors.dart';

class StatusComponent extends StatelessWidget {
  String status;
  StatusComponent({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
        status=="Active"?AppColors.PRIMARYCOLOR: Colors.red,
        borderRadius:
        BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(10),
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:[
          CircleAvatar(
            radius: 3,
            backgroundColor:
            Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(status,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}