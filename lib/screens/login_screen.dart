import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/firebase/references.dart';
import 'package:flutter_app_catalogo/screens/main_screen.dart';
import 'package:flutter_app_catalogo/screens/signUp_screen.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color bgButton = Colors.transparent;
  TextStyle tsButton = TextStyles.bodyText;

  String email = "";
  String pass = "";
  String idUser;

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
                      onChanged: updateEmail,
                      hint: 'abc@email.com',
                      validator: valEmail,
                      initText: "",
                    ),
                    TextFieldForm(
                      icon: Icons.lock_outline,
                      text: "Contraseña",
                      type: TextInputType.text,
                      obscureText: true,
                      onChanged: updateContrasena,
                      hint: 'Contraseña',
                      validator: valContrasena,
                      initText: "",
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
                  if (_formKey.currentState.validate()) {
                    valLogin();
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

  //   UPDATES
  void updateEmail(String value) {
    this.email = value;
  }

  void updateContrasena(String value) {
    this.pass = value;
  }

  // VALIDATORS
  String valEmail(String value) {
    if (value.isEmpty) {
      return "Campo vacio";
    } else if (!value.contains("@") || !value.contains(".")) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  String valContrasena(String value) {
    if (value.isEmpty) {
      return "Campo vacio";
    } else {
      return null;
    }
  }

  Future<void> valLogin() async {
    await Firebase.initializeApp();

    References.users.where("email", isEqualTo: email).get().then(
          (value) => {
            if (value.docs.isNotEmpty)
              {
                if (value.docs.first.get("password") == pass)
                  {
                    idUser = value.docs.first.id,
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainScreen(idUser)))
                  }
                else
                  {
                    ShowDialog(context, "Error",
                        "Usuario o contraseña incorrecta", "ACEPTAR", false)
                  }
              }
            else
              {
                ShowDialog(context, "Error", "Usuario o contraseña incorrecta",
                    "ACEPTAR", false)
              }
          },
        );
  }
}
