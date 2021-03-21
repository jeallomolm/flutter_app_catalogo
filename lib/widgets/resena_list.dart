import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/models/models.dart';
import 'package:flutter_app_catalogo/widgets/resena_item.dart';

class ResenaList extends StatefulWidget {
  final int id;

  ResenaList(this.id);

  @override
  _ResenaListState createState() => _ResenaListState(id);
}

class _ResenaListState extends State<ResenaList> {
  List<Widget> resenas = [];

  int id;

  _ResenaListState(this.id) {
    updateResenas();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: resenas,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 60.0,
            decoration: BoxDecoration(
              color: Palette.principal,
            ),
            child: Center(
                child: Text(
              "Calificar",
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }

  updateResenas() {
    findResenas();

    if (resenas.isEmpty) {
      resenas.add(
        Container(
          padding: EdgeInsets.only(top: 150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sin resultados.",
                style: TextStyles.infoText,
              ),
              Text(
                "No hay reseñas para mostrar",
                style: TextStyles.infoText,
              ),
            ],
          ),
        ),
      );
    }
  }

  findResenas() {
    int i;

    resenas.clear();
    for (i = 0; i < resenasData.length; i++) {
      if (resenasData[i].idRestaurant == id) {
        resenas.add(ResenaItem(resenasData[i].user, resenasData[i].resena,
            resenasData[i].calificacion));
      }
    }
  }

  refresh() {
    setState(() {
      updateResenas();
    });
  }
}
