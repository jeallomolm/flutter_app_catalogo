import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/firebase/references.dart';
import 'package:firebase_core/firebase_core.dart';

class InfoRestaurant extends StatefulWidget {
  final String idRestaurant;
  final String horario;
  final String direccion;
  final String image;

  InfoRestaurant(this.horario, this.direccion, this.image, this.idRestaurant);

  @override
  _InfoRestaurantState createState() =>
      _InfoRestaurantState(horario, direccion, image, idRestaurant);
}

class _InfoRestaurantState extends State<InfoRestaurant> {
  String idRestaurant;
  String horario;
  String direccion;
  String image;
  int calificacion = -1;

  Future<int> _calificacion;

  @override
  void initState() {
    _calificacion = getCalificacion();
    super.initState();
  }

  _InfoRestaurantState(
      this.horario, this.direccion, this.image, this.idRestaurant);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Horario del restaurante",
            style: TextStyles.infoText.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            horario,
            style: TextStyles.infoText,
          ),
          SizedBox(height: 20.0),
          Text(
            "Dirección del restaurante",
            style: TextStyles.infoText.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            direccion,
            style: TextStyles.infoText,
          ),
          SizedBox(height: 20.0),
          Text(
            "Calificación promedio",
            style: TextStyles.infoText.copyWith(fontWeight: FontWeight.bold),
          ),
          FutureBuilder(
              future: _calificacion,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != -1) {
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyles.infoText,
                    );
                  } else {
                    return Text(
                      "c/a",
                      style: TextStyles.infoText,
                    );
                  }
                } else {
                  return Text(
                    "c/a",
                    style: TextStyles.infoText,
                  );
                }
              })),
        ],
      ),
    );
  }

  Future<int> getCalificacion() async {
    await Firebase.initializeApp();

    int cont = 0;
    int acum = 0;

    await References.resenas
        .where("idRestaurant", isEqualTo: idRestaurant)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                cont++;
                acum += element.get("calificacion");
              })
            });

    if (cont == 0) {
      calificacion = -1;
    } else {
      calificacion = acum ~/ cont;
    }

    return calificacion;
  }
}
