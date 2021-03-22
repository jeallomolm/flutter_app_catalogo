import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/firebase/references.dart';
import 'package:flutter_app_catalogo/models/models.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

class FavoritesList extends StatefulWidget {
  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  List<Widget> restaurantsFav = [];

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
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 21.0),
              child: Text(
                "Favoritos",
                style: TextStyles.bodyText
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              child: FutureBuilder(
                  future: _myList,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      updateRestaurantsFav();
                      return Column(
                        children: restaurantsFav,
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

  updateRestaurantsFav() {
    if (favsData.isEmpty) {
      restaurantsFav.clear();
      restaurantsFav.add(
        Container(
          padding: EdgeInsets.only(top: 250.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sin favoritos.",
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
    } else {
      int i;
      restaurantsFav.clear();
      for (i = 0; i < favsData.length; i++) {
        restaurantsFav.add(RestaurantItem(
            favsData[i].id,
            favsData[i].horario,
            favsData[i].name,
            favsData[i].direccion,
            favsData[i].image,
            refresh));
      }
    }
  }

  refresh() {
    setState(() {
      updateRestaurantsFav();
    });
  }

  Future<List> listarRestaurantes() async {
    await Firebase.initializeApp();

    favsData.clear();
    await References.favs
        .where("idUser", isEqualTo: userIDa)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                print(element.get("idRestaurant"));
                References.restaurants
                    .doc(element.get("idRestaurant"))
                    .get()
                    .then((rest) => {
                          addData(
                              rest.get("name"),
                              rest.get("horario"),
                              rest.get("direccion"),
                              rest.id,
                              rest.get("image")),
                        });
              })
            });

    return favsData;
  }

  void addData(
      String name, String horario, String direccion, String id, String image) {
    setState(() {
      favsData.add(Restaurant(name, horario, direccion, id, image));
    });
  }
}
