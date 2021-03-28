import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/data/restaurants.dart';
import 'package:flutter_app_catalogo/firebase/references.dart';
import 'package:flutter_app_catalogo/models/models.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();

  RestaurantList() : super(key: UniqueKey());
}

class _RestaurantListState extends State<RestaurantList> {
  List<RestaurantItem> restaurantsList = [];
  List<RestaurantItem> restaurantsListBackup = [];

  Future<List> _myList;

  @override
  void initState() {
    _myList = listarRestaurantes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Text("GOURMET",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold)),
                ),
              ),
              TextFieldForm(
                icon: Icons.search,
                text: "",
                type: TextInputType.text,
                obscureText: false,
                hint: 'Buscar',
                onChanged: filtro,
                validator: (dynamic) {},
                initText: "",
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              child: FutureBuilder(
                  future: _myList,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      //buildBackup();
                      if (restaurantsList.isEmpty) {
                        return Column(children: [
                          Text(
                            "Sin resultados.",
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "No hay restaurantes para mostrar.",
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 18.0),
                          ),
                        ]);
                      } else {
                        return Column(
                          children: restaurantsList,
                        );
                      }
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
      ],
    );
  }

  void filtro(String filtro) {
    this.setState(() {
      if (filtro != "") {
        restaurantsList = restaurantsListBackup
            .where((element) =>
                element.name.toLowerCase().contains(filtro.toLowerCase()))
            .toList();
      } else {
        restaurantsList = restaurantsListBackup;
      }
    });
  }

  buildBackup() {
    restaurantsListBackup.clear();
    int i;
    for (i = 0; i < restaurantsData.length; i++) {
      restaurantsListBackup.cast().add(RestaurantItem(
          restaurantsData[i].id,
          restaurantsData[i].horario,
          restaurantsData[i].name,
          restaurantsData[i].direccion,
          restaurantsData[i].image,
          () {}));
    }

    if (restaurantsListBackup.isEmpty) {
      restaurantsListBackup.cast<Widget>().add(
            Container(
              padding: EdgeInsets.only(top: 250.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sin resultados.",
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "No hay restaurantes para mostrar.",
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 18.0),
                  ),
                ],
              ),
            ),
          );
    }

    restaurantsList = restaurantsListBackup;
  }

  Future<List> listarRestaurantes() async {
    await Firebase.initializeApp();

    restaurantsList.clear();
    await References.restaurants.get().then((value) => {
          if (value.docs.isNotEmpty)
            {
              value.docs.forEach((element) {
                restaurantsList.add(RestaurantItem(
                    element.id,
                    element.get("horario"),
                    element.get("name"),
                    element.get("direccion"),
                    element.get("image"),
                    () {}));
              })
            }
        });

    setState(() {
      restaurantsListBackup = restaurantsList;
    });

    return restaurantsData;
  }

  void addData(
      String name, String horario, String direccion, String id, String image) {
    setState(() {
      restaurantsData.add(Restaurant(name, horario, direccion, id, image));
    });
  }
}
