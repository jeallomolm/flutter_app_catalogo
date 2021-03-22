import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/data/restaurants.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  List<Widget> restaurantsList = [];

  _RestaurantListState() {
    if (restaurantsList.isEmpty) {
      int i;
      for (i = 0; i < restaurantsData.length; i++) {
        restaurantsList.add(RestaurantItem(
            restaurantsData[i].name, restaurantsData[i].image, () {}));
      }
    }
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
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: restaurantsList,
              ),
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
              restaurantsData[i].name, restaurantsData[i].image, () {}));
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
}
