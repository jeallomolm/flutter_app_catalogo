import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/screens/signUp_screen.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color bgButton = Colors.transparent;
  TextStyle tsButton = TextStyles.bodyText;
  bool disable = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.scaffold,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 80.0),
                  Text("Gourmet", style: TextStyles.titleText),
                  SizedBox(height: 30.0),
                  Text(
                    "Bienvenido a Gourmet",
                    style: TextStyles.bodyText
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16.0),
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
                  ),
                  TextFieldForm(
                    icon: Icons.lock_outline,
                    text: "Contraseña",
                    type: TextInputType.text,
                    obscureText: true,
                  ),
                ],
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
                  setState(() {
                    if (disable) {
                      bgButton = Palette.principal;
                      tsButton = tsButton.copyWith(color: Colors.white);
                    } else {
                      bgButton = Colors.transparent;
                      tsButton = tsButton.copyWith(color: Palette.principal);
                    }
                    disable = !disable;
                  });
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
                //margin: EdgeInsets.all(5.0),
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
}
