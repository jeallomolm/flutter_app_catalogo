import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/models/models.dart';
import 'package:flutter_app_catalogo/widgets/resena_textfield.dart';
import 'package:flutter_app_catalogo/widgets/textFieldForm.dart';

class AddResena extends StatefulWidget {
  final int id;
  final String name;
  final String image;
  final Function() refresh;

  AddResena(this.id, this.name, this.refresh, this.image);

  @override
  _AddResenaState createState() => _AddResenaState(id, name, refresh, image);
}

class _AddResenaState extends State<AddResena> {
  int id;
  String image;
  String name;
  Function() refresh;

  Color bgButton = Colors.transparent;
  TextStyle tsButton = TextStyles.bodyText;
  bool disable = true;

  String resenaText = "";
  double calificacion;

  final _formKey = GlobalKey<FormState>();

  _AddResenaState(this.id, this.name, this.refresh, this.image);

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
              resenasData.add(
                  Resena(id, resenaText, users[userID].name, calificacion));
              refresh();
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

  void updateCalificacion(String calificacion) {
    this.calificacion = double.parse(calificacion);
  }

  void updateResena(String resena) {
    if (resena.isEmpty || resena == null) {
      resenaText = "123";
    } else {
      resenaText = resena;
    }
  }
}
