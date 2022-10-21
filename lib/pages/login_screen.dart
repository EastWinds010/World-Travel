import 'package:flutter/material.dart';
import 'package:learning_dart/controllers/controller_login.dart';
import 'package:learning_dart/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ControllerLogin controllerLogin = ControllerLogin();
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
            child: SizedBox(
                width: size.width * .94,
                height: size.height * .7,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white.withOpacity(0.65),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/initial_screen');
                            },
                            icon: Icon(Icons.arrow_back_rounded)),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: size.width * 0.05),
                          child: SizedBox(
                            child: Image.asset('assets/images/logo1_black.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.width * .1),
                        child: CustomTextFormField(
                          text: 'EMAIL',
                          controller: controllerLogin.email,
                          showPassword: false,
                          isPass: false,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.width * .1),
                        child: CustomTextFormField(
                          changeShowPassword: () {
                            setState(() {
                              controllerLogin.showPass =
                                  !controllerLogin.showPass;
                            });
                          },
                          showPassword: controllerLogin.showPass,
                          isPass: true,
                          text: 'PASSWORD',
                          controller: controllerLogin.password,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.width * .1),
                        child: SizedBox(
                          width: size.width * 0.7,
                          child: ElevatedButton(
                              onPressed: () {
                                controllerLogin.onLogin(context);
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ))),
                              child: Text('LOGIN',
                                  style: TextStyle(
                                      fontSize: size.width * 0.07,
                                      color: Colors.white,
                                      fontFamily: 'RobotoThin'))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.width * .01),
                        child: SizedBox(
                          width: size.width * 0.7,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.white.withOpacity(0.65)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: const BorderSide(
                                              width: 1.2,
                                              color: Colors.black)))),
                              child: Text('FORGOT PASSWORD',
                                  style: TextStyle(
                                      fontSize: size.width * 0.07,
                                      color: Colors.black,
                                      fontFamily: 'RobotoThin'))),
                        ),
                      ),
                    ],
                  ),
                )),
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
