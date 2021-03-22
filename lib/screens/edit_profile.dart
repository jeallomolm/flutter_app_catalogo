import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/widgets/dialog.dart';
import 'package:flutter_app_catalogo/widgets/textFieldForm.dart';

class EditProfileUser extends StatefulWidget {
  @override
  _EditProfileUserState createState() => _EditProfileUserState();
}

class _EditProfileUserState extends State<EditProfileUser> {
  final _key = GlobalKey<FormState>();

  Color emailVal = Palette.principal;
  Color celularVal = Palette.principal;

  Color bgButton = Colors.transparent;
  TextStyle tsButton = TextStyles.bodyText;
  bool disable = true;

  String email = "";
  String celular = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.scaffold,
        appBar: AppBar(
          backgroundColor: Palette.scaffold,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Palette.principal,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
              child: Text(
            "Actualizar Datos",
          )),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.grey, blurRadius: 5),
              ], color: Palette.scaffold),
              child: Column(
                children: [
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10.0,
                      ),
                      hasAvatar(),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        users[userID].name,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    TextFieldForm(
                      icon: Icons.email_outlined,
                      text: "E-mail",
                      type: TextInputType.emailAddress,
                      obscureText: false,
                      hint: users[userID].email,
                      callback: valEmail,
                    ),
                    TextFieldForm(
                      icon: Icons.phone_outlined,
                      text: "Celular",
                      type: TextInputType.number,
                      obscureText: false,
                      hint: users[userID].number,
                      callback: valCelular,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            setState(() {
              if (_key.currentState.validate()) {
                if (email.isNotEmpty && email != null) {
                  users[userID].setEmail(email);
                }
                if (celular.isNotEmpty && celular != null) {
                  users[userID].setNumber(celular);
                }
                ShowDialog(context, "Actualizar",
                    "Sus datos fueron actualizados con éxito", "ACEPTAR");
              }
            });
          },
          child: Container(
            height: 60.0,
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Palette.principal, width: 2.0),
                right: BorderSide(color: Palette.principal, width: 2.0),
                top: BorderSide(color: Palette.principal, width: 2.0),
                bottom: BorderSide(color: Palette.principal, width: 2.0),
              ),
              color: bgButton,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
                child: Text(
              "Enviar calificación",
              style: tsButton,
            )),
          ),
        ),
      ),
    );
  }

  Widget hasAvatar() {
    if (users[userID].avatar == "" || users[userID].avatar == null) {
      return Icon(
        Icons.account_circle,
        color: Palette.principal,
        size: MediaQuery.of(context).size.width / 5,
      );
    } else {
      return CircleAvatar(
        radius: MediaQuery.of(context).size.width / 10,
        backgroundImage: AssetImage("images/restaurants/cuzco.png"),
      );
    }
  }

  void valEmail(String value) {
    email = value;

    if (value.contains("@") && value.contains(".")) {
      emailVal = Palette.principal;
    } else {
      emailVal = Colors.red;
    }
  }

  void valCelular(String value) {
    celular = value;

    if (value.isEmpty) {
      celularVal = Palette.principal;
    } else {
      celularVal = Colors.red;
    }
  }
}
