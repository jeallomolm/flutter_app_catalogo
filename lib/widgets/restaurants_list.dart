import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/widgets/widgets.dart';

class RestaurantsList extends StatelessWidget {
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
                children: [
                  RestaurantItem(),
                  RestaurantItem(),
                  RestaurantItem(),
                  RestaurantItem(),
                  RestaurantItem(),
                  RestaurantItem(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
