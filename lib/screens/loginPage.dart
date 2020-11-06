import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_forms/screens/signUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color _bottomBackground = Color(0xff0DB8C6);
  Color _topBackground = Color(0xff0DC69E);
  bool _showPassword = true;

  String _email, _password;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void toggle() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_topBackground, _bottomBackground])),
        child: Container(
            margin: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            padding: EdgeInsets.only(top: 50),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Login Page",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return "Please fill out this field";
                        }
                        if (!RegExp(
                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(input)) {
                          return "Please fill out a valid email";
                        }
                        return null;
                      },
                      onSaved: (input) {
                        _email = input;
                      },
                      decoration: InputDecoration(
                         prefixIcon: Icon(
                            Icons.email,
                              color: Colors.grey[700],
                             ),
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.black),
                         enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.blue)),      
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.white)), 
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.red[400])),
                          focusedErrorBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.red[400])),     
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return "Please fill out this field";
                        }
                        if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                            .hasMatch(input)) {
                          return "password must contain atleast one uppercase letter, a \nlowercase letter and a number ";
                        }
                        return null;
                      },
                      onSaved: (input) {
                        _password = input;
                      },
                      obscureText: _showPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey[700],
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(_showPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            toggle();
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.white)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.red[400])),
                        focusedErrorBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.red[400])),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              child: Text(
                            "forget password",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        onPressed: () {
                          login();
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        splashColor: Colors.red,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                        width: 360,
                        height: 50,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            color: Colors.white,
                            child: Text("Create an account",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black))),
                      )
                    ]),
                  ],
                ))),
      ),
    );
  }

  void login() {
    if (!_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }
}
