class Resena {
  int _idRestaurant;
  String _resena;
  String _user;
  double _calificacion;

  Resena(this._idRestaurant, this._resena, this._user, this._calificacion);

  double get calificacion => _calificacion;

  String get user => _user;

  String get resena => _resena;

  int get idRestaurant => _idRestaurant;
}
