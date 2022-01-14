import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tarstest/core/core.dart';
import 'package:tarstest/home/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.green500),
      child: AnimatedSplashScreen(
        splash: Image.asset("assets/images/logo.png"),
        nextScreen: (HomePage()),
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
