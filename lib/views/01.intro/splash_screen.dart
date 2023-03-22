
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../config/constant_colors.dart';
import '../../config/constant_images.dart';
import 'Login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
 Widget build(BuildContext context){
    return AnimatedSplashScreen(
      splash:  Image.asset(AppImages.LOGOWhite),
      nextScreen: LoginScreen(),
      duration:3000,
      backgroundColor: AppColors.PRIMARYCOLOR,
      splashIconSize: 100,
      animationDuration: Duration(seconds: 2),
      pageTransitionType:PageTransitionType.rightToLeft ,
      splashTransition: SplashTransition.fadeTransition,



    );
  }
}
