import 'package:flutter/material.dart';
import 'package:flutter_app_catalogo/config/config.dart';
import 'package:flutter_app_catalogo/data/data.dart';
import 'package:flutter_app_catalogo/screens/add_restaurant.dart';
import 'package:flutter_app_catalogo/screens/edit_profile.dart';
import 'package:flutter_app_catalogo/screens/login_screen.dart';

class ProfileUser extends StatefulWidget {
  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 5),
          ], color: Palette.scaffold),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Perfil",
                    style: TextStyles.bodyText
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  hasAvatar(),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    users[userID].name,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Editar perfil"),
                    leading: Icon(
                      Icons.edit,
                      color: Palette.principal,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.arrow_right,
                        color: Colors.grey[800],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileUser()));
                      },
                    ),
                  ),
                  addRestaurantButton(),
                  ListTile(
                    title: Text("Cerrar sesión"),
                    leading: Icon(
                      Icons.exit_to_app_outlined,
                      color: Palette.principal,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.arrow_right,
                        color: Colors.grey[800],
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget hasAvatar() {
    if (users[userID].avatar == "" || users[userID].avatar == null) {
      return Icon(
        Icons.account_circle,
        color: Palette.principal,
        size: MediaQuery.of(context).size.width / 5,
      );
    } else {
      return CircleAvatar(
        radius: MediaQuery.of(context).size.width / 10,
        backgroundImage: AssetImage("images/restaurants/cuzco.png"),
      );
    }
  }

  Widget addRestaurantButton() {
    if (users[userID].profile == Profile.admin) {
      return ListTile(
        title: Text("Agregar restaurante"),
        leading: Icon(
          Icons.restaurant,
          color: Palette.principal,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.arrow_right,
            color: Colors.grey[800],
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddRestaurant()));
          },
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
