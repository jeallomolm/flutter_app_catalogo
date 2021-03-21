import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';

class ResenaTextField extends StatefulWidget {
  final Function update;

  ResenaTextField(this.update);

  @override
  _ResenaTextFieldState createState() => _ResenaTextFieldState(update);
}

class _ResenaTextFieldState extends State<ResenaTextField> {
  Function update;

  _ResenaTextFieldState(this.update);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Escribir reseña ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "(Opcional) ",
              )
            ],
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {
                update(value);
              });
            },
            maxLines: 3,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Container(
                height: 50.0,
                padding: EdgeInsets.only(right: 15.0),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                  color: Palette.principal.withOpacity(0.5),
                ))),
                child: Icon(
                  Icons.edit,
                  color: Palette.principal,
                ),
              ),
              hintText: "Escribe tu reseña",
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
