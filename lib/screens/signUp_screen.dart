import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Color bgButton = Colors.transparent;
  TextStyle tsButton = TextStyles.bodyText;
  bool disable = true;

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
                Column(
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
                    ),
                    TextFieldForm(
                      icon: Icons.email_outlined,
                      text: "E-mail",
                      type: TextInputType.emailAddress,
                      obscureText: false,
                    ),
                    TextFieldForm(
                      icon: Icons.lock_outline,
                      text: "Contraseña",
                      type: TextInputType.text,
                      obscureText: true,
                    ),
                    TextFieldForm(
                      icon: Icons.phone_outlined,
                      text: "Celular",
                      type: TextInputType.number,
                      obscureText: false,
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (disable) {
                            bgButton = Palette.principal;
                            tsButton = tsButton.copyWith(color: Colors.white);
                          } else {
                            bgButton = Colors.transparent;
                            tsButton =
                                tsButton.copyWith(color: Palette.principal);
                          }
                          disable = !disable;
                        });
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
}
