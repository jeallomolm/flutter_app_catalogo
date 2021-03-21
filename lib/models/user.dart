import 'package:flutter_app_catalogo/config/config.dart';

class User {
  String _avatar;
  String _name;
  String _password;
  String _email;
  String _number;
  Profile _profile;

  User(this._name, this._password, this._email, this._number, this._profile,
      this._avatar);

  Profile get profile => _profile;

  String get number => _number;

  String get email => _email;

  String get password => _password;

  String get name => _name;

  String get avatar => _avatar;

  setNumber(String value) {
    _number = value;
  }

  setEmail(String value) {
    _email = value;
  }

  setPassword(String value) {
    _password = value;
  }

  setName(String value) {
    _name = value;
  }

  setAvatar(String value) {
    _avatar = value;
  }
}
