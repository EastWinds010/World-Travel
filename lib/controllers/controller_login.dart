import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning_dart/models/model_login.dart';
import 'package:learning_dart/service/service_login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerLogin {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  UserLogin? loginUser;
  ServiceLoginUser serciceLoginUser = ServiceLoginUser();
  bool showPass = true;

  void verificedLogin(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String validator = preferences.get('Validator').toString();
    serciceLoginUser.getUsers();
    if (validator == '200') {
      print(validator);
      Navigator.pushReplacementNamed(context, '/map_screen');
    } else {
      Navigator.pushReplacementNamed(context,'/initial_screen');
    }
  }

  onLogin(BuildContext context) async {
    loginUser = UserLogin();
    Map login = {
      "email": email.text,
      "password": password.text,
    };
    loginUser = UserLogin.fromJson(login);
    await serciceLoginUser
        .loginUser(loginUser!.sendToJson())
        .then((loginResult) {
      switch (loginResult) {
        case 200:
          Navigator.pushReplacementNamed(context, '/map_screen');
          break;
        default:
          Fluttertoast.showToast(
              msg: 'LOGIN OU SENHA INCORRETOS', fontSize: 16);
      }
    });
  }
}
