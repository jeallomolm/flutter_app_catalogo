import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/firebase/references.dart';
import 'package:flutter_app_catalogo/widgets/dialog.dart';
import 'package:flutter_app_catalogo/widgets/textFieldForm.dart';
import 'package:firebase_core/firebase_core.dart';

class EditProfileUser extends StatefulWidget {
  final String emailActual;
  final String numberActual;

  const EditProfileUser(this.emailActual, this.numberActual);

  @override
  _EditProfileUserState createState() =>
      _EditProfileUserState(emailActual, numberActual);
}

class _EditProfileUserState extends State<EditProfileUser> {
  final _key = GlobalKey<FormState>();

  Color emailVal = Palette.principal;
  Color celularVal = Palette.principal;

  Color bgButton = Colors.transparent;
  TextStyle tsButton = TextStyles.bodyText;
  bool disable = true;

  String email = " ";
  String number = " ";

  Future<String> _name;

  String emailActual;
  String numberActual;

  _EditProfileUserState(this.emailActual, this.numberActual) {
    email = emailActual;
    number = numberActual;
  }

  @override
  void initState() {
    super.initState();

    _name = getNameUser();
  }

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
              child: Text("Actualizar Datos",
                  style: TextStyles.bodyText
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18.0))),
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
                      FutureBuilder(
                          future: _name,
                          builder: ((context, snapshot) {
                            if (snapshot.hasData) {
                              return Text((snapshot.data));
                            } else {
                              return Text("Cargando...");
                            }
                          })),
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
                        hint: "Nuevo correo",
                        onChanged: updateEmail,
                        validator: valEmail,
                        initText: emailActual,
                      ),
                      TextFieldForm(
                        icon: Icons.phone_outlined,
                        text: "Celular",
                        type: TextInputType.number,
                        obscureText: false,
                        hint: "Nuevo celular",
                        onChanged: updateNumber,
                        validator: valNumber,
                        initText: numberActual,
                      ),
                    ],
                  )),
            ),
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            setState(() {
              if (_key.currentState.validate()) {
                updateUser();
                ShowDialog(context, "Actualizar",
                    "Sus datos fueron actualizados con éxito", "ACEPTAR", true);
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

  //   UPDATES
  void updateEmail(String value) {
    this.email = value;
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

  String valNumber(String value) {
    if (value.isEmpty) {
      return "Campo vacio";
    } else {
      return null;
    }
  }

  Future<String> getNameUser() async {
    await Firebase.initializeApp();
    String aux;

    await References.users.doc(userIDa).get().then((value) => {
          aux = value.get("name"),
        });

    return aux;
  }

  Future<String> getDataUser() async {
    await Firebase.initializeApp();
    String aux;

    await References.users.doc(userIDa).get().then((value) => {
          aux = value.get("name"),
          /*number = value.get("number"),
          email = value.get("email"),*/
        });

    return aux;
  }

  Future<void> updateUser() async {
    await Firebase.initializeApp();

    References.users.doc(userIDa).update({"email": email, "number": number});
  }
}
