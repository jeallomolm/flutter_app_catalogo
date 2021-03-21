import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/data/data.dart';

class RestaurantScreen extends StatefulWidget {
  final int id;
  final Function notify;

  RestaurantScreen(this.id, this.notify);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState(id, notify);
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  int id;
  Function notify;

  IconButton fav;

  _RestaurantScreenState(this.id, this.notify) {
    print(isFav());
    if (!isFav()) {
      fav = IconButton(
        icon: Icon(
          Icons.favorite_border,
          color: Colors.grey,
        ),
        onPressed: onPressedButton,
      );
    } else {
      fav = IconButton(
        icon: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        onPressed: onPressedButton,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [fav],
      ),
      body: Container(
        child: Text("adsasd " + id.toString()),
      ),
    ));
  }

  bool isFav() {
    int i;
    bool fav = false;

    for (i = 0; i < favsData.length; i++) {
      if (favsData[i].name == restaurantsData[this.id].name) {
        fav = true;
      }
    }

    return fav;
  }

  onPressedButton() {
    setState(() {
      if (isFav()) {
        fav = IconButton(
          icon: Icon(
            Icons.favorite_border,
            color: Colors.grey,
          ),
          onPressed: onPressedButton,
        );
        favsData.removeAt(id);
      } else {
        fav = IconButton(
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          onPressed: onPressedButton,
        );
        favsData.add(restaurantsData[id]);
      }
    });
  }
}
