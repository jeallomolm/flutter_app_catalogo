import 'package:flutter/material.dart';

class ShowDialog {
  BuildContext context;
  String title;
  String text;
  String button;

  ShowDialog(this.context, this.title, this.text, this.button) {
    show(context, title, text, button);
  }

  Function show(
      BuildContext context, String title, String text, String button) {
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
              },
            )
          ],
        );
      },
    );
  }
}
