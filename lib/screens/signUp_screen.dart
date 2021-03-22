import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/firebase/references.dart';
import 'package:flutter_app_catalogo/models/models.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Color bgButton = Colors.transparent;
  TextStyle tsButton = TextStyles.bodyText;

  String name;
  String email;
  String pass;
  String number;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.scaffold,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Form(
                  onChanged: () {
                    setState(() {
                      _formKey.currentState.validate()
                          ? bgButton = Palette.principal
                          : bgButton = Colors.transparent;
                      _formKey.currentState.validate()
                          ? tsButton =
                              TextStyles.bodyText.copyWith(color: Colors.white)
                          : tsButton = TextStyles.bodyText;
                    });
                  },
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80.0,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Palette.principal,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Text("Gourmet", style: TextStyles.titleText),
                      SizedBox(height: 30.0),
                      Text(
                        "Bienvenido a Gourmet",
                        style: TextStyles.bodyText.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Regístrate",
                        style: TextStyles.bodyText,
                      ),
                      SizedBox(height: 50.0),
                      TextFieldForm(
                        icon: Icons.person_outline,
                        text: "Nombre Completo",
                        type: TextInputType.text,
                        obscureText: false,
                        onChanged: updateName,
                        hint: 'Cesar Rodriguez',
                        validator: valName,
                      ),
                      TextFieldForm(
                        icon: Icons.email_outlined,
                        text: "E-mail",
                        type: TextInputType.emailAddress,
                        obscureText: false,
                        onChanged: updateEmail,
                        hint: 'abc123@correo.com',
                        validator: valEmail,
                      ),
                      TextFieldForm(
                        icon: Icons.lock_outline,
                        text: "Contraseña",
                        type: TextInputType.text,
                        obscureText: true,
                        hint: 'Contraseña',
                        onChanged: updatePassword,
                        validator: valPassword,
                      ),
                      TextFieldForm(
                        icon: Icons.phone_outlined,
                        text: "Celular",
                        type: TextInputType.number,
                        obscureText: false,
                        hint: '1231234567',
                        onChanged: updateNumber,
                        validator: valNumber,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            addUser();
                          });
                          Navigator.pop(context);
                          ShowDialog(
                              context,
                              "Crear usuario",
                              "El usuario se ha creado exitosamente",
                              "ACEPTAR");
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                                color: Palette.principal, width: 2.0),
                            right: BorderSide(
                                color: Palette.principal, width: 2.0),
                            top: BorderSide(
                                color: Palette.principal, width: 2.0),
                            bottom: BorderSide(
                                color: Palette.principal, width: 2.0),
                          ),
                          color: bgButton,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                              child: Text(
                            "Continuar",
                            style: tsButton,
                          )),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "¿Ya tienes una cuenta? ",
                                style: TextStyles.bodyText,
                              ),
                              GestureDetector(
                                child: Text(
                                  "Inicia sesión",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //   UPDATES
  void updateEmail(String value) {
    this.email = value;
  }

  void updatePassword(String value) {
    this.pass = value;
  }

  void updateName(String value) {
    this.name = value;
  }

  void updateNumber(String value) {
    this.number = value;
  }

  //   VALIDATORS
  String valEmail(String value) {
    if (value.isEmpty) {
      return "Campo vacio";
    } else if (!value.contains("@") || !value.contains(".")) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  String valPassword(String value) {
    if (value.isEmpty) {
      return "Campo vacio";
    } else {
      return null;
    }
  }

  String valName(String value) {
    if (value.isEmpty) {
      return "Campo vacio";
    } else {
      return null;
    }
  }

  String valNumber(String value) {
    if (value.isEmpty) {
      return "Campo vacio";
    } else {
      return null;
    }
  }

  Future<void> addUser() async {
    await Firebase.initializeApp();

    Map<String, dynamic> user = {
      "email": email,
      "favs": Map<String, String>(),
      "name": name,
      "number": number,
      "password": pass,
      "typeUser": 0,
    };

    References.users.add(user);
  }
}
