import 'package:flutter/material.dart';

class ShowDialog {
  BuildContext context;
  String title;
  String text;
  String button;
  bool goBack;

  ShowDialog(this.context, this.title, this.text, this.button, this.goBack) {
    show(context, title, text, button, goBack);
  }

  show(BuildContext context, String title, String text, String button,
      bool goBack) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: <Widget>[
            ElevatedButton(
              child: Text(
                button,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                goBack ? Navigator.of(context).pop() : goBack = goBack;
              },
            )
          ],
        );
      },
    );
  }
}
