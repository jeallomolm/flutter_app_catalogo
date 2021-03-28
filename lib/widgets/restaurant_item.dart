import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/screens/restaurant_screen.dart';

bool _visible = true;

class RestaurantItem extends StatefulWidget {
  final String id;
  final String horario;
  final String _name;
  final String direccion;
  final String image;
  final Function() refresh;

  RestaurantItem(this.id, this.horario, this._name, this.direccion, this.image,
      this.refresh)
      : super(key: UniqueKey());

  @override
  _RestaurantItemState createState() => _RestaurantItemState(this.id,
      this.horario, this._name, this.direccion, this.image, this.refresh);

  String get name => _name;

  bool get visible => _visible;
}

class _RestaurantItemState extends State<RestaurantItem> {
  String id;
  String horario;
  String _name;
  String direccion;
  String image;
  Function() refresh;

  _RestaurantItemState(this.id, this.horario, this._name, this.direccion,
      this.image, this.refresh);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RestaurantScreen(
                      id, horario, _name, refresh, image, direccion)));
          refresh();
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
              child: Text(_name, style: TextStyles.RestaurantItemText),
            ),
          ]),
        ),
      ),
    );
  }
}
