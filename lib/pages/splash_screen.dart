import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:daily_excersises/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';

class TimeManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1500,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/splash_screen.png",),
          Text("Run Your Day", style: Theme
              .of(context)
              .textTheme
              .overline!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 30, shadows: [
                Shadow(
                  color: Colors.pinkAccent,
                  blurRadius: 4,
                ),
          ])),
        ],
      ),
      nextScreen: HomePage(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Colors.white,
      splashIconSize: 1000,
    );
  }
}
