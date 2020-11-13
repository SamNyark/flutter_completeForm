import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
        backgroundColor: Colors.blue
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text("sign out"),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              })
          ],),
      ),
    );
  }
}
