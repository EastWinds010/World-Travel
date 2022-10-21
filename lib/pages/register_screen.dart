import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_dart/controllers/controller_register.dart';
import 'package:learning_dart/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ControllerRegister controllerRegister = ControllerRegister();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: size.width * .14),
          child: Column(
            children: [
              CustomTextFormField(
                isPass: false,
                showPassword: false,
                text: 'NAME',
                controller: controllerRegister.displayName,
              ),
              Padding(
                padding: EdgeInsets.only(top: size.width * .05),
                child: CustomTextFormField(
                  isPass: false,
                  showPassword: false,
                  text: 'EMAIL',
                  controller: controllerRegister.email,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.width * .05),
                child: CustomTextFormField(
                  isPass: true,
                  showPassword: controllerRegister.showPass,
                  changeShowPassword: () {
                    setState(() {
                      controllerRegister.showPass =
                          !controllerRegister.showPass;
                    });
                  },
                  text: 'PASSWORD',
                  controller: controllerRegister.password,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.width * .05),
                child: CustomTextFormField(
                  isPass: true,
                  showPassword: controllerRegister.showRepeatPass,
                  changeShowPassword: () {
                    setState(() {
                      controllerRegister.showRepeatPass =
                          !controllerRegister.showRepeatPass;
                    });
                  },
                  text: 'CONFIRMED PASSWORD',
                  controller: controllerRegister.confirmedPassword,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.width * .05),
                child: Text('ADD IMAGE PROFILE',
                    style: TextStyle(
                        fontSize: size.width * 0.07,
                        fontFamily: 'RobotoBold',
                        color: Colors.black)),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.width * .05),
                child: SizedBox(
                  width: size.width * .3,
                  height: size.height * .15,
                  child: controllerRegister.file == null
                      ? CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Image.asset(
                            'assets/images/add_profile.png',
                            color: Colors.white,
                          ),
                        )
                      : controllerRegister.loading
                          ? const Center(child: CircularProgressIndicator())
                          : ClipOval(
                              child: Image.file(
                              File(controllerRegister.file!.path),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )),
                ),
              ),
              Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () async {
                          await controllerRegister
                              .getImage(ImageSource.gallery);
                          setState(() {});
                        },
                        icon: const Icon(Icons.image),
                        color: Colors.black),
                    IconButton(
                        onPressed: () async {
                          await controllerRegister.getImage(ImageSource.camera);
                          setState(() {});
                        },
                        icon: const Icon(Icons.camera_alt_outlined),
                        color: Colors.black)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.width * .15),
                child: SizedBox(
                  width: size.width * 0.7,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (controllerRegister.password.text ==
                            controllerRegister.confirmedPassword.text) {
                          setState(() {
                            controllerRegister.loading = true;
                          });
                          await controllerRegister.buildContextBody(context);
                          setState(() {
                            controllerRegister.loading = false;
                          });
                        }
                        else {
                          Fluttertoast.showToast(
                            msg: 'SENHAS NÃO COICIDEM'
                          
                          );
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(
                                      width: 1, color: Colors.black)))),
                      child: Text('SIGN UP',
                          style: TextStyle(
                              fontSize: size.width * 0.07,
                              fontFamily: 'RobotoThin',
                              color: Colors.white))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.width * .06),
                child: Image.asset('assets/images/logo_black.png'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
