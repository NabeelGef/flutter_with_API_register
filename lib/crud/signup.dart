import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController data_name = new TextEditingController();
  TextEditingController data_email = new TextEditingController();
  TextEditingController data_password = new TextEditingController();
  String name, password, email, msg = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Text(
                "Signup Page",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
                child: Transform.scale(
                    scale: 2.5, child: Image.asset('images/logoLogin.png'))),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: data_name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.green)),
                          hintText: "username",
                          prefixIcon: Icon(Icons.person)),
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: data_password,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.green)),
                          hintText: "password",
                          prefixIcon: Icon(Icons.lock)),
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: data_email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.green)),
                          hintText: "email",
                          prefixIcon: Icon(Icons.person)),
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            "If have an account",
                            style: TextStyle(fontSize: 20),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("loginPage");
                            },
                            child: Text(" click Here",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    decoration: TextDecoration.underline)),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(20),
                        child: ElevatedButton(
                          onPressed: () {
                            saveInDB();
                          },
                          style: Colors.green,
                          child: Text(
                            "Signup",
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                  ],
                )),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  saveInDB() async {
    var Url = Uri.parse('http://10.0.2.2:3000/api/register');
    final data = jsonEncode({
      'name': data_name.text,
      'email': data_email.text,
      'password': data_password.text
    });
    try {
      var res = await http.post(Url,
          body: data,
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      if (res.statusCode == 200) {
        msg = "success register!!";
        setState(() {
          showSnackBar(msg);
          Timer(Duration(seconds: 3),
              () => {Navigator.of(context).pushNamed("homepage")});
        });
      } else {
        msg = "failed register!!";
        setState(() {
          showSnackBar(msg);
        });
      }
    } on SocketException catch (_) {
      msg = "failed in connection";
      setState(() {
        showSnackBar(msg);
      });
    }
  }

  void showSnackBar(String msg) {
    final SnackBar snackBar = new SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
