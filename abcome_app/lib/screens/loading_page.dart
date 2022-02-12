import 'package:abcome_app/screens/home_page.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);
  static const String id = '/loading';

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        duration: 2000,
        animationDuration: const Duration(milliseconds: 2000),
        splash: const Image(
          image: AssetImage('images/logotipo.png'),
        ),
        splashIconSize: 300,
        nextScreen: const HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
