
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout {
  logout(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Navigator.pushReplacementNamed(context,'/login_screen');
  }
}
