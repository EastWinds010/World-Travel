import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splash.png',
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: size.width * .5),
              child: Column(
                children: [
                  SizedBox(
                    child: Image.asset('assets/images/logo1_white.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.width * .14),
                    child: SizedBox(
                      width: size.width * 0.7,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context,'/register_screen');
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: const BorderSide(
                                          width: 1, color: Colors.white)))),
                          child: Text('SIGN UP',
                              style: TextStyle(
                                  fontSize: size.width * 0.07,
                                  fontFamily: 'RobotoThin'))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.width * .03),
                    child: SizedBox(
                      width: size.width * 0.7,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login_screen');
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ))),
                          child: Text('LOGIN',
                              style: TextStyle(
                                  fontSize: size.width * 0.07,
                                  color: Colors.black,
                                  fontFamily: 'RobotoThin'))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: size.width * .08),
              child: Image.asset('assets/images/logo_white.png'),
            ),
          )
        ],
      ),
    );
  }
}
