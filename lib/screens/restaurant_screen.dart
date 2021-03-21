import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/widgets/info_restaurant.dart';
import 'package:flutter_app_catalogo/widgets/resena_list.dart';

final PageController controller = PageController(initialPage: 0);

class RestaurantScreen extends StatefulWidget {
  final String name;
  final String image;
  final Function() refresh;

  RestaurantScreen(this.name, this.refresh, this.image);

  @override
  _RestaurantScreenState createState() =>
      _RestaurantScreenState(name, refresh, image);
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  String image;
  String name;
  Function() refresh;

  IconButton fav;
  BorderSide borderSideInfo = BorderSide(color: Palette.principal, width: 2.0);
  BorderSide borderSideResenas = BorderSide.none;
  int id;

  _RestaurantScreenState(this.name, this.refresh, this.image) {
    id = findId();

    if (!isFav()) {
      fav = IconButton(
        icon: Icon(
          Icons.favorite_border,
          color: Palette.principal,
        ),
        onPressed: onPressedButton,
      );
    } else {
      fav = IconButton(
        icon: Icon(
          Icons.favorite,
          color: Palette.principal,
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
        backgroundColor: Palette.scaffold,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Palette.principal,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
            child: Text(name,
                style: TextStyle(color: Colors.black, fontSize: 18.0))),
        actions: [fav],
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 4.0,
                  width: MediaQuery.of(context).size.width - 20.0,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image(
                      image: AssetImage("images/restaurants/" + image),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        borderSideInfo =
                            BorderSide(color: Palette.principal, width: 2.0);
                        borderSideResenas = BorderSide.none;
                        controller.animateToPage(0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.decelerate);
                      });
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border(bottom: borderSideInfo)),
                      padding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                      child: Center(
                        child: Text(
                          "Información",
                          style: TextStyles.bodyText,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        borderSideInfo = BorderSide.none;
                        borderSideResenas =
                            BorderSide(color: Palette.principal, width: 2.0);
                        controller.animateToPage(1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.decelerate);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: borderSideResenas)),
                      padding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                      child: Center(
                        child: Text(
                          "Reseñas",
                          style: TextStyles.bodyText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView(
                scrollDirection: Axis.vertical,
                controller: controller,
                children: [
                  InfoRestaurant(id),
                  ResenaList(id),
                ],
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  bool isFav() {
    int i;
    bool fav = false;

    for (i = 0; i < favsData.length; i++) {
      if (favsData[i].name == name) {
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
            color: Palette.principal,
          ),
          onPressed: onPressedButton,
        );
        deleteRestaurant();
      } else {
        fav = IconButton(
          icon: Icon(
            Icons.favorite,
            color: Palette.principal,
          ),
          onPressed: onPressedButton,
        );
        addRestaurant();
      }
      refresh();
    });
  }

  addRestaurant() {
    int i;

    for (i = 0; i < restaurantsData.length; i++) {
      if (restaurantsData[i].name == name) {
        favsData.add(restaurantsData[i]);
      }
    }
  }

  deleteRestaurant() {
    int i;

    for (i = 0; i < favsData.length; i++) {
      if (favsData[i].name == name) {
        favsData.removeAt(i);
      }
    }
  }

  int findId() {
    int i;

    for (i = 0; i < restaurantsData.length; i++) {
      if (restaurantsData[i].name == name) {
        return i;
      }
    }

    return -1;
  }
}
