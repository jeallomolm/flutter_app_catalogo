import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/firebase/references.dart';
import 'package:flutter_app_catalogo/widgets/resena_textfield.dart';
import 'package:flutter_app_catalogo/widgets/textFieldForm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:date_format/date_format.dart';

class AddResena extends StatefulWidget {
  final String idRestaurant;
  final String name;
  final String image;
  final String userName;

  AddResena(this.idRestaurant, this.name, this.image, this.userName);

  @override
  _AddResenaState createState() =>
      _AddResenaState(idRestaurant, name, image, userName);
}

class _AddResenaState extends State<AddResena> {
  String idRestaurant;
  String image;
  String name;
  String username;

  Color bgButton = Colors.transparent;
  TextStyle tsButton = TextStyles.bodyText;
  bool disable = true;

  String resenaText = " ";
  int calificacion;

  final _formKey = GlobalKey<FormState>();

  _AddResenaState(this.idRestaurant, this.name, this.image, this.username);

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
            child:
                Text("Calificar", style: TextStyle(color: Palette.principal))),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 35.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        " Calificar a " + name + ".",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        " Por favor, haz una una reseña sobre el restaurante.",
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 4.0,
                              width: MediaQuery.of(context).size.width - 20.0,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image(
                                  image:
                                      AssetImage("images/restaurants/" + image),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFieldForm(
                          icon: Icons.star_border,
                          text: "",
                          type: TextInputType.number,
                          obscureText: false,
                          hint: "Estrellas",
                          onChanged: updateCalificacion,
                          validator: valCalificacion,
                          initText: "",
                        )
                      ],
                    ),
                    ResenaTextField(updateResena),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          setState(() {
            if (_formKey.currentState.validate()) {
              addResena();
              Navigator.pop(context);
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
    ));
  }

  //   UPDATES
  void updateCalificacion(String value) {
    this.calificacion = double.parse(value
            .replaceFirst(".", "^")
            .replaceAll(".", "")
            .replaceAll("^", "."))
        .toInt();
  }

  void updateResena(String value) {
    if (value != "") {
      this.resenaText = value;
    } else {
      this.resenaText = " ";
    }
  }

  //   VALIDATORS
  String valCalificacion(String value) {
    int auxValue = double.parse(value
            .replaceFirst(".", "^")
            .replaceAll(".", "")
            .replaceAll("^", "."))
        .toInt();

    if (value.isEmpty) {
      return "Campo vacio.";
    } else if (auxValue < 0 || auxValue > 5) {
      return "El rango va desde 0 a 5 estrellas.";
    } else {
      return null;
    }
  }

  Future<void> addResena() async {
    await Firebase.initializeApp();

    String date = formatDate(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        [dd, '-', M, '-', yyyy]);

    Map<String, dynamic> resena = {
      "idRestaurant": idRestaurant,
      "name": username,
      "resena": resenaText,
      "calificacion": calificacion,
      "date": date,
    };

    References.resenas.add(resena);
  }
}
