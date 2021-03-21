import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/data/restaurants.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';

List<RestaurantItem> restaurantsFavs = [];

class RestaurantList extends StatefulWidget {
  final Function notify;

  @override
  _RestaurantListState createState() => _RestaurantListState();
  RestaurantList(this.notify) {
    if (restaurantsFav.isEmpty) {
      int i;
      for (i = 0; i < restaurantsData.length; i++) {
        restaurantsFavs.add(RestaurantItem(
            restaurantsData[i].name, restaurantsData[i].image, i, notify));
      }
    }
  }
}

class _RestaurantListState extends State<RestaurantList> {
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
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: restaurantsFavs,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
