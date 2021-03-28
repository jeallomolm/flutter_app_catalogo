class Resena {
  String _resena;
  String _user;
  int _calificacion;
  String _date;

  Resena(this._resena, this._user, this._calificacion, this._date);

  int get calificacion => _calificacion;

  String get user => _user;

  String get resena => _resena;

  String get date => _date;
}
