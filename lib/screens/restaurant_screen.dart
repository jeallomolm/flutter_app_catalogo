import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/firebase/references.dart';
import 'package:flutter_app_catalogo/widgets/dialog.dart';
import 'package:flutter_app_catalogo/widgets/info_restaurant.dart';
import 'package:flutter_app_catalogo/widgets/resena_list.dart';
import 'package:firebase_core/firebase_core.dart';

final PageController controller = PageController(initialPage: 0);

class RestaurantScreen extends StatefulWidget {
  final String id;
  final String horario;
  final String name;
  final String direccion;
  final String image;
  final Function() refresh;

  RestaurantScreen(this.id, this.horario, this.name, this.refresh, this.image,
      this.direccion);

  @override
  _RestaurantScreenState createState() =>
      _RestaurantScreenState(id, horario, name, refresh, image, direccion);
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  String id;
  String horario;
  String image;
  String name;
  String direccion;
  Function() refresh;

  IconButton fav;
  BorderSide borderSideInfo = BorderSide(color: Palette.principal, width: 2.0);
  BorderSide borderSideResenas = BorderSide.none;

  _RestaurantScreenState(this.id, this.horario, this.name, this.refresh,
      this.image, this.direccion) {
    fav = IconButton(
      icon: Icon(
        Icons.favorite_border,
        color: Palette.principal,
      ),
      onPressed: onPressedButton,
    );
    isFav();
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
                  /*InfoRestaurant(id),
                  ResenaList(id),*/
                ],
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  onPressedButton() async {
    bool isFav = await isFavorito();

    setState(() {
      if (isFav) {
        fav = IconButton(
          icon: Icon(
            Icons.favorite_border,
            color: Palette.principal,
          ),
          onPressed: onPressedButton,
        );
        deleteRestaurant();
        ShowDialog(context, "Favoritos",
            "El restaurante ha sido eliminado de favoritos", "ACEPTAR", false);
      } else {
        fav = IconButton(
          icon: Icon(
            Icons.favorite,
            color: Palette.principal,
          ),
          onPressed: onPressedButton,
        );
        addRestaurant();
        ShowDialog(context, "Favoritos",
            "El restaurante ha sido agregado a favoritos", "ACEPTAR", false);
      }
      refresh();
    });
  }

  addRestaurant() {
    addFavorito();
  }

  deleteRestaurant() {
    deleteFavorito();
  }

  Future<void> addFavorito() async {
    await Firebase.initializeApp();

    Map<String, dynamic> favorito = {
      "idUser": userIDa,
      "idRestaurant": id,
    };

    References.favs.add(favorito);
  }

  Future<void> deleteFavorito() async {
    await Firebase.initializeApp();

    String delete;

    await References.favs
        .where("idUser", isEqualTo: userIDa)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                if (element.get("idRestaurant") == id) {
                  delete = element.id;
                }
              })
            });

    References.favs.doc(delete).delete();
  }

  Future<bool> isFavorito() async {
    await Firebase.initializeApp();

    bool fav = false;

    await References.favs
        .where("idUser", isEqualTo: userIDa)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                if (element.get("idRestaurant") == id) {
                  fav = true;
                }
              })
            });

    return fav;
  }

  void isFav() async {
    bool isfav = await isFavorito();
    setState(() {
      if (!isfav) {
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
    });
  }
}
