import 'package:flutter/material.dart';
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
                child: Text("GOURMET"),
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
              color: Colors.green,
              child: Column(
                children: [
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
