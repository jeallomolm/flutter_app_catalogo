import 'package:flutter/material.dart';

class ResenaItem extends StatelessWidget {
  final String user;
  final String resena;
  final int calificaion;
  final String date;

  ResenaItem(this.user, this.resena, this.calificaion, this.date);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: Card(
        child: ListTile(
          trailing: Text(date),
          title: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              user,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(calificaion.toString()),
                SizedBox(height: 5.0),
                Text(resena),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
