import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController data_email = new TextEditingController();
  TextEditingController data_password = new TextEditingController();
  String name, password, email, msg = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Text(
                "Login Page",
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
                      controller: data_email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.green)),
                          hintText: "email",
                          prefixIcon: Icon(Icons.email)),
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
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            "If have not account",
                            style: TextStyle(fontSize: 20),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("signupPage");
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
                            connectionWithDB();
                          },
                          style: Colors.green,
                          child: Text(
                            "Login",
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

  connectionWithDB() async {
    var Url = Uri.parse('http://10.0.2.2:3000/api/login');
    var data =
        jsonEncode({'email': data_email.text, 'password': data_password.text});
    var head = {'Content-Type': 'application/json; charset=UTF-8'};

    try {
      var res = await http.post(Url, body: data, headers: head);

      res.statusCode == 200
          ? {
              setState(() {
                msg = 'success';
                showSnackBar(msg);
                Timer(
                    Duration(seconds: 3),
                    () => {
                          Navigator.of(context).pushReplacementNamed("homepage")
                        });
              })
            }
          : {
              setState(() {
                msg = 'failure';
                showSnackBar(msg);
              })
            };
    } on SocketException catch (_) {
      msg = "failed in connection";
      setState(() {
        showSnackBar(msg);
      });
    }
  }

  void showSnackBar(String msg) {
    SnackBar snackBar = new SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
