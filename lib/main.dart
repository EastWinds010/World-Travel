// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:learning_dart/pages/initial_screen.dart';
import 'package:learning_dart/pages/login_screen.dart';
import 'package:learning_dart/pages/map_screen.dart';
import 'package:learning_dart/pages/register_screen.dart';
import 'package:learning_dart/pages/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash_screen',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash_screen':
            return PageTransition(
                child: SplashScreen(), type: PageTransitionType.fade, duration: Duration(milliseconds:1000), reverseDuration: Duration(milliseconds: 1000));
          case '/initial_screen':
            return PageTransition(
                child: InitialScreen(), type: PageTransitionType.fade,duration: Duration(milliseconds:1000), reverseDuration: Duration(milliseconds: 1000));
          case '/login_screen':
            return PageTransition(
                child: LoginScreen(), type: PageTransitionType.fade, duration: Duration(milliseconds:1000), reverseDuration: Duration(milliseconds: 1000));
          case '/map_screen':
            return PageTransition(
                child: MapScreen(), type: PageTransitionType.fade, duration: Duration(milliseconds:1000), reverseDuration: Duration(milliseconds: 1000));
          case '/register_screen':
            return PageTransition(
                child: RegisterScreen(), type: PageTransitionType.fade, duration: Duration(milliseconds:1000), reverseDuration: Duration(milliseconds: 1000));
        }
      },
    );
  }
}
