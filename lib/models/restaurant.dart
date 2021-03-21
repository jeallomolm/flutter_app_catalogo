class Restaurant {
  String _name;
  String _image;
  String _horario;
  String _direccion;
  double _calificacion;

  Restaurant(this._name, this._horario, this._direccion, this._calificacion, this._image);

  String get name => _name;

  String get horario => _horario;

  double get calificacion => _calificacion;

  String get direccion => _direccion;

  String get image => _image;
}
