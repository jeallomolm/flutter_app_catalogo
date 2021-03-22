import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/screens/main_screen.dart';
import 'package:flutter_app_catalogo/screens/signUp_screen.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color bgButton = Colors.transparent;
  TextStyle tsButton = TextStyles.bodyText;
  bool disable = true;

  String email = "";
  String pass = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.scaffold,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 80.0),
                    Text("Gourmet", style: TextStyles.titleText),
                    SizedBox(height: 30.0),
                    Text(
                      "Bienvenido a Gourmet",
                      style: TextStyles.bodyText.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Inicia sesión",
                      style: TextStyles.bodyText,
                    ),
                    SizedBox(height: 50.0),
                    TextFieldForm(
                      icon: Icons.email_outlined,
                      text: "E-mail",
                      type: TextInputType.emailAddress,
                      obscureText: false,
                      onChanged: valEmail,
                      hint: 'abc@email.com',
                    ),
                    TextFieldForm(
                      icon: Icons.lock_outline,
                      text: "Contraseña",
                      type: TextInputType.text,
                      obscureText: true,
                      onChanged: valContrasena,
                      hint: 'Contraseña',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 110.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  createRecord();
                  if (_formKey.currentState.validate()) {
                    bool correct = false;

                    for (int i = 0; i < users.length; i++) {
                      if (users[i].email == email) {
                        if (users[i].password == pass) {
                          correct = true;
                          userID = i;
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()));
                        }
                      }
                    }

                    if (!correct) {
                      ShowDialog(context, "Error",
                          "Usuario o contraseña incorrecta", "ACEPTAR");
                    }
                  }
                },
                child: Container(
                  height: 60.0,
                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
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
                    "Continuar",
                    style: tsButton,
                  )),
                ),
              ),
              Container(
                height: 50.0,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "¿No tienes una cuenta? ",
                        style: TextStyles.bodyText,
                      ),
                      GestureDetector(
                        child: Text(
                          "Regístrate",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void valEmail(String value) {
    this.email = value;
  }

  void valContrasena(String value) {
    this.pass = value;
  }

  void createRecord() async {
    await Firebase.initializeApp();

    await FirebaseFirestore.instance.collection("books").doc("1").set({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });

    DocumentReference ref =
        await FirebaseFirestore.instance.collection("books").add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
  }
}
