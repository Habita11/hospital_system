
import 'package:flutter/material.dart';

import '../../config/constant_colors.dart';

class DefaultTextField extends StatelessWidget {
var suffixColor;
String labelText;
IconData iconData;
bool obscure;
bool isEnabled;
bool autoFocus;
Widget? suffix;
String? Function(String?)? validator;
TextEditingController controller;
void Function(String)? onSubmit;
Function()? onTap;
 DefaultTextField({
   this.onTap,
   this.autoFocus=false,
   this.isEnabled=true,
   this.suffixColor,
   required this.controller,
   this.validator,
   this.onSubmit,
  required this.iconData,
  required this.labelText,
   this.obscure=false ,
   this.suffix=null
});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20,bottom: 20),
    width: MediaQuery.of(context).size.width*.4,
    child:TextFormField(
      autofocus: autoFocus,
      enabled: isEnabled,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      validator:validator ,
      controller:controller ,
      obscureText:obscure ,
      decoration: InputDecoration(
        suffixIconColor: suffixColor,
         suffixIcon: suffix,
          floatingLabelStyle:const TextStyle(
              color: AppColors.PRIMARYCOLOR
          ),
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:const BorderSide(
                color: AppColors.PRIMARYCOLOR
            ),
          ) ,
          icon: Icon(iconData),
          labelText:labelText ,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
          )
      ),
    ));
  }
}
