import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forms/screens/signUp.dart';
import 'package:flutter_forms/widgets/forgetPassword.dart';

import '../authentication_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color _bottomBackground = Color(0xff0DB8C6);
  Color _topBackground = Color(0xff0DC69E);
  bool _showPassword = true;

  String _email, _password;
  String _error;
  String _incorrectError = "Incorrect password";
  String _userNotFoundError = "No user with this credentials";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void toggle() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        focusedErrorBorder: OutlineInputBorder(
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
                        focusedErrorBorder: OutlineInputBorder(
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
                          onTap: () {
                            popUpDialog(context);
                          },
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
                      child: Builder(
                        builder: (context) => RaisedButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                            }
                            context.read<AuthenticationService>().signIn(
                                email: _email,
                                password: _password,
                                );
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Icon(Icons.error_rounded),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(AuthenticationService.errorMessage,
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)))));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          splashColor: Colors.red,
                        ),
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
                              Navigator.of(context).push(
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
}
