import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';

List<Widget> restaurantsFav = [];

class FavoritesList extends StatefulWidget {
  final Function notify;

  @override
  _FavoritesListState createState() => _FavoritesListState();

  FavoritesList(this.notify) {
    if (favsData.isEmpty) {
      restaurantsFav.clear();
      restaurantsFav.add(
        Container(
          padding: EdgeInsets.only(top: 250.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Aun no has agregado restaurants a esta sección",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18.0),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "¿Qué esperas? Encuentra tu primer lugar favorito!!!",
                style:
                    TextStyles.bodyText.copyWith(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      );
    } else {
      int i;
      restaurantsFav.clear();
      for (i = 0; i < favsData.length; i++) {
        restaurantsFav.add(
            RestaurantItem(favsData[i].name, favsData[i].image, i, notify));
      }
    }
  }
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "Favoritos",
                style: TextStyles.bodyText
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 22.0),
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
}
