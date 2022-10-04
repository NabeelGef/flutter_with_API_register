import 'package:flutter/material.dart';

import 'crud/Home.dart';
import 'crud/Login.dart';
import 'crud/signup.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "loginPage": (context) => Login(),
        "signupPage": (context) => Signup(),
        "homepage": (context) => Home(),
      },
      theme: ThemeData(
          primaryColor: Colors.red,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.red,
          )),
      home: Login()));
}
