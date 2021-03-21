import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/models/models.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';

class AddRestaurant extends StatefulWidget {
  @override
  _EditProfileUserState createState() => _EditProfileUserState();
}

class _EditProfileUserState extends State<AddRestaurant> {
  final _key = GlobalKey<FormState>();

  Color nameVal = Palette.principal;
  Color direccionVal = Palette.principal;
  Color horarioVal = Palette.principal;

  Color bgButton = Colors.transparent;
  TextStyle tsButton = TextStyles.bodyText;
  bool disable = true;

  String name = "";
  String direccion = "";
  String horario = "";

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
              child: Text("Agregar restaurante",
                  style: TextStyle(color: Palette.principal))),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Portada",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Toma una foto horizontal para que tus clientes conozcan tus restaurante.",
                ),
              ),
              Form(
                key: _key,
                child: Column(
                  children: [
                    TextFieldForm(
                      icon: Icons.business_outlined,
                      text: "Nombre del restaurante",
                      type: TextInputType.text,
                      obscureText: false,
                      hint: "Capitalino",
                      callback: valName,
                    ),
                    TextFieldForm(
                      icon: Icons.location_on_outlined,
                      text: "Dirección",
                      type: TextInputType.text,
                      obscureText: false,
                      hint: "Cra 5 #28 - 15",
                      callback: valDireccion,
                    ),
                    TextFieldForm(
                      icon: Icons.watch_later_outlined,
                      text: "Horario",
                      type: TextInputType.text,
                      obscureText: false,
                      hint: "De lunes a viernes",
                      callback: valHorario,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            setState(() {
              if (_key.currentState.validate()) {
                restaurantsData.add(
                    Restaurant(name, horario, direccion, 0.0, "cuzco.png"));
                ShowDialog(context, "Agregar",
                    "El restaurante fue agregado exitosamente", "ACEPTAR");
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
              "Agregar",
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

  void valName(String value) {
    name = value;
  }

  void valDireccion(String value) {
    direccion = value;
  }

  void valHorario(String value) {
    horario = value;
  }
}
