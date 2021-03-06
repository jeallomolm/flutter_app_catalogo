import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/firebase/references.dart';
import 'package:flutter_app_catalogo/models/models.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

final PageController controller = PageController(initialPage: 0);

class MainScreen extends StatefulWidget {
  MainScreen(String idUser) {
    userIDa = idUser;
    listarRestaurantes();
  }

  @override
  _MainScreenState createState() => _MainScreenState();

  Future<void> listarRestaurantes() async {
    await Firebase.initializeApp();

    References.restaurants.get().then((value) => {
          value.docs.forEach((element) {
            restaurantsData.add(Restaurant(
                element.data()["name"],
                element.data()["horario"],
                element.data()["direccion"],
                element.id,
                element.data()["image"]));
          })
        });
  }
}

class _MainScreenState extends State<MainScreen> {
  Color btList = Palette.principal;
  Color btFavs = Colors.grey;
  Color btProfile = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              children: [
                RestaurantList(),
                FavoritesList(),
                ProfileUser(),
              ],
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
          Container(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(top: 15.0, bottom: 25.0),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: btList, width: 2.0),
                      ),
                    ),
                    child: Icon(
                      Icons.search,
                      color: btList,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      btList = Palette.principal;
                      btFavs = Colors.grey;
                      btProfile = Colors.grey;
                      controller.animateToPage(0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.decelerate);
                    });
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(top: 15.0, bottom: 25.0),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: btFavs, width: 2.0),
                      ),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: btFavs,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      btList = Colors.grey;
                      btFavs = Palette.principal;
                      btProfile = Colors.grey;
                      controller.animateToPage(1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.decelerate);
                    });
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(top: 15.0, bottom: 25.0),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: btProfile, width: 2.0),
                      ),
                    ),
                    child: Icon(
                      Icons.account_circle_rounded,
                      color: btProfile,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      btList = Colors.grey;
                      btFavs = Colors.grey;
                      btProfile = Palette.principal;
                      controller.animateToPage(2,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.decelerate);
                    });
                  },
                ),
              ),
            ],
          ))
        ],
      ),
    ));
  }
}
