import 'package:flutter/material.dart';

class RestaurantItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 4.5,
              width: MediaQuery.of(context).size.width - 20.0,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image(
                  image:
                      AssetImage("images/restaurants/osaka_cocina_nikkei.png"),
                ),
              ),
            )),
      ),
    );
  }
}
