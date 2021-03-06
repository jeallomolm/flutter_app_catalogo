import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';

class TextFieldForm extends StatefulWidget {
  final IconData icon;
  final String text;
  final String hint;
  final TextInputType type;
  final bool obscureText;
  final Function onChanged;
  final Function validator;
  final String initText;

  const TextFieldForm(
      {Key key,
      @required this.icon,
      @required this.text,
      @required this.type,
      @required this.obscureText,
      @required this.hint,
      @required this.onChanged,
      @required this.validator,
      @required this.initText})
      : super(key: key);

  @override
  _TextFieldFormState createState() => _TextFieldFormState(
      icon, text, type, obscureText, hint, onChanged, validator, initText);
}

class _TextFieldFormState extends State<TextFieldForm> {
  IconData icon;
  String text;
  String hint;
  TextInputType type;
  bool obscureText;
  Function onChanged;
  Function validator;
  String initText;

  _TextFieldFormState(this.icon, this.text, this.type, this.obscureText,
      this.hint, this.onChanged, this.validator, this.initText);

  Color iconColor = Palette.principal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText(),
          TextFormField(
            initialValue: initText,
            validator: validator,
            onChanged: (value) {
              setState(() {
                onChanged(value);
              });
            },
            obscureText: obscureText,
            keyboardType: type,
            decoration: InputDecoration(
              icon: Container(
                padding: EdgeInsets.only(right: 15.0),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                  color: Palette.principal.withOpacity(0.5),
                ))),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget getText() {
    if (this.text != null && this.text != "") {
      return Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    } else {
      return SizedBox();
    }
  }
}
