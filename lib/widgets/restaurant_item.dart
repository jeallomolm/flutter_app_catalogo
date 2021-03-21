import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/screens/restaurant_screen.dart';

class RestaurantItem extends StatelessWidget {
  final String name;
  final String image;
  final Function() refresh;

  RestaurantItem(this.name, this.image, this.refresh);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RestaurantScreen(name, refresh, image)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        child: Stack(children: [
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
          Container(
            height: (MediaQuery.of(context).size.height / 4.0) - 10.0,
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: 15.0),
            child: Text(name, style: TextStyles.RestaurantItemText),
          ),
        ]),
      ),
    );
  }
}
