import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/models/models.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Color bgButton = Colors.transparent;
  TextStyle tsButton = TextStyles.bodyText;
  bool disable = true;

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
                        callback: valName,
                        hint: 'Cesar Rodriguez',
                      ),
                      TextFieldForm(
                        icon: Icons.email_outlined,
                        text: "E-mail",
                        type: TextInputType.emailAddress,
                        obscureText: false,
                        callback: valEmail,
                        hint: 'abc123@correo.com',
                      ),
                      TextFieldForm(
                        icon: Icons.lock_outline,
                        text: "Contraseña",
                        type: TextInputType.text,
                        obscureText: true,
                        hint: 'Contraseña',
                        callback: valContrasena,
                      ),
                      TextFieldForm(
                        icon: Icons.phone_outlined,
                        text: "Celular",
                        type: TextInputType.number,
                        obscureText: false,
                        hint: '1231234567',
                        callback: valNum,
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
                            users.add(User(
                                name, pass, email, number, Profile.user, ""));
                          });
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

  void valEmail(String value) {
    this.email = value;
  }

  void valContrasena(String value) {
    this.pass = value;
  }

  void valName(String value) {
    this.name = value;
  }

  void valNum(String value) {
    this.number = value;
  }
}
