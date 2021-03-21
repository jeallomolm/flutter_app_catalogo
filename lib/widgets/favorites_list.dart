import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';

class FavoritesList extends StatefulWidget {
  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  List<Widget> restaurantsFav = [];

  _FavoritesListState() {
    updateRestaurantsFav();
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
              child: Column(
                children: restaurantsFav,
              ),
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
        restaurantsFav
            .add(RestaurantItem(favsData[i].name, favsData[i].image, refresh));
      }
    }
  }

  refresh() {
    setState(() {
      updateRestaurantsFav();
    });
  }
}
