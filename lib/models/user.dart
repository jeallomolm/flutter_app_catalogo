import 'package:flutter_app_catalogo/config/config.dart';

class User {
  String _name;
  String _password;
  String _email;
  String _number;
  Profile _profile;

  User(this._name, this._password, this._email, this._number, this._profile);

  Profile get profile => _profile;

  String get number => _number;

  String get email => _email;

  String get password => _password;

  String get name => _name;
}
