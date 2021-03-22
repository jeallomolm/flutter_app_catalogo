import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/data/restaurants.dart';
import 'package:flutter_app_catalogo/firebase/references.dart';
import 'package:flutter_app_catalogo/models/models.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  List<Widget> restaurantsList = [];

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
                      restaurantsList = List.from(crear(snapshot.data));
                      return Column(
                        children: restaurantsList,
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
      ],
    );
  }

  void filtro(String filtro) {
    setState(() {
      restaurantsList.clear();
      int i;
      for (i = 0; i < restaurantsData.length; i++) {
        if (restaurantsData[i]
            .name
            .toLowerCase()
            .contains(filtro.toLowerCase())) {
          restaurantsList.add(RestaurantItem(
              restaurantsData[i].id,
              restaurantsData[i].horario,
              restaurantsData[i].name,
              restaurantsData[i].direccion,
              restaurantsData[i].image,
              () {}));
        }
      }

      if (restaurantsList.isEmpty) {
        restaurantsList.add(
          Container(
            padding: EdgeInsets.only(top: 250.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sin resultados.",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18.0),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "No hay restaurantes para mostrar.",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18.0),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  Future<List> listarRestaurantes() async {
    await Firebase.initializeApp();

    restaurantsData.clear();
    await References.restaurants.get().then((value) => {
          value.docs.forEach((element) {
            addData(element.get("name"), element.get("horario"),
                element.get("direccion"), element.id, element.get("image"));
          })
        });

    /*for (int i = 0; i < restaurantsData.length; i++) {
      print(restaurantsData[i].id);
    }*/

    return restaurantsData;
  }

  void addData(
      String name, String horario, String direccion, String id, String image) {
    setState(() {
      restaurantsData.add(Restaurant(name, horario, direccion, id, image));
    });
  }

  List<Widget> crear(List list) {
    restaurantsList.clear();
    int i;
    for (i = 0; i < list.length; i++) {
      restaurantsList.add(RestaurantItem(list[i].id, list[i].horario,
          list[i].name, list[i].direccion, list[i].image, () {}));
    }

    if (restaurantsList.isEmpty) {
      restaurantsList.add(
        Container(
          padding: EdgeInsets.only(top: 250.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sin resultados.",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18.0),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "No hay restaurantes para mostrar.",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18.0),
              ),
            ],
          ),
        ),
      );
    }
    return restaurantsList;
  }
}
