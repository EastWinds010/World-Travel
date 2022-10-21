import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learning_dart/controllers/controller_login.dart';
import 'package:learning_dart/pages/initial_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () => ControllerLogin().verificedLogin(context));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          'assets/images/splash.png',
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: size.width * .08),
            child: Image.asset('assets/images/logo_white.png'),
          ),
        )
      ],
    );
  }
}
