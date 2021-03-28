import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/firebase/references.dart';
import 'package:flutter_app_catalogo/models/models.dart';
import 'package:flutter_app_catalogo/screens/add_resena.dart';
import 'package:flutter_app_catalogo/widgets/resena_item.dart';
import 'package:firebase_core/firebase_core.dart';

class ResenaList extends StatefulWidget {
  final String idRestaurant;
  final String name;
  final String image;

  ResenaList(this.idRestaurant, this.name, this.image);

  @override
  _ResenaListState createState() => _ResenaListState(idRestaurant, name, image);
}

class _ResenaListState extends State<ResenaList> {
  List<Widget> resenas = [];

  String idRestaurant;
  String name;
  String image;

  _ResenaListState(this.idRestaurant, this.name, this.image) {
    updateResenas();
  }

  Future<List> _myList;

  @override
  void initState() {
    _myList = listarResenas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              child: FutureBuilder(
                  future: _myList,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      updateResenas();
                      return Column(
                        children: resenas,
                      );
                    } else {
                      return Column(
                        children: [
                          Container(
                            child: CircularProgressIndicator(strokeWidth: 10),
                            margin: EdgeInsets.only(top: 100.0),
                          )
                        ],
                      );
                    }
                  })),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            String userName;

            await References.users
                .doc(userIDa)
                .get()
                .then((value) => userName = value.get("name"));

            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddResena(idRestaurant, name, image, userName)));
            refresh();
          },
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
    if (resenasData.isEmpty) {
      resenas.clear();
      resenas.add(
        Container(
          padding: EdgeInsets.only(top: 150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sin reseñas.",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18.0),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "No hay reseñas para mostrar.",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18.0),
              ),
            ],
          ),
        ),
      );
    } else {
      int i;
      resenas.clear();
      for (i = 0; i < resenasData.length; i++) {
        resenas.add(ResenaItem(resenasData[i].user, resenasData[i].resena,
            resenasData[i].calificacion, resenasData[i].date));
      }
    }
  }

  refresh() async {
    await listarResenas();
    setState(() {
      updateResenas();
    });
  }

  Future<List> listarResenas() async {
    await Firebase.initializeApp();

    resenasData.clear();
    await References.resenas
        .where("idRestaurant", isEqualTo: idRestaurant)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                addData(
                  element.get("resena"),
                  element.get("name"),
                  element.get("calificacion"),
                  element.get("date"),
                );
              })
            });

    return favsData;
  }

  void addData(String resena, String user, int calificacion, String date) {
    setState(() {
      resenasData.add(Resena(resena, user, calificacion, date));
    });
  }
}
