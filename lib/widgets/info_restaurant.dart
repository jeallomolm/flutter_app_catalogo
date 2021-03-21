import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';

class InfoRestaurant extends StatelessWidget {
  final int id;

  InfoRestaurant(this.id);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Horario del restaurante",
            style: TextStyles.infoText.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            restaurantsData[id].horario,
            style: TextStyles.infoText,
          ),
          SizedBox(height: 20.0),
          Text(
            "Dirección del restaurante",
            style: TextStyles.infoText.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            restaurantsData[id].direccion,
            style: TextStyles.infoText,
          ),
          SizedBox(height: 20.0),
          Text(
            "Calificación promedio",
            style: TextStyles.infoText.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            restaurantsData[id].calificacion.toString(),
            style: TextStyles.infoText,
          ),
        ],
      ),
    );
  }
}
