import 'package:flutter/material.dart';

class MainAlertDialog extends StatelessWidget {
 String title;
 Widget content;
 List<Widget>? actions;

 MainAlertDialog({
   required this.title,
   required this.content,
   required this.actions,
});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title:  Text(
        title,
        style: const TextStyle(
            color: Colors.black,
            fontWeight:
            FontWeight.bold,
            fontSize: 25),
      ),
      content:  content,
      actions: actions,
    );
  }
}
