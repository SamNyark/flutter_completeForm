import 'package:flutter/material.dart';

void popUpDialog(BuildContext context) {
  final _controller = TextEditingController();

  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text("Enter sent code"),
          content: TextField(
            controller: _controller,
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "cancel",
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                )),
            FlatButton(
                onPressed: () {},
                child: Text(
                  "Dont Send",
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ))
          ],
        );
      });
}
