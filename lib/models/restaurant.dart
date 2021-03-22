class Restaurant {
  String _name;
  String _image;
  String _horario;
  String _direccion;
  String _id;

  Restaurant(this._name, this._horario, this._direccion, this._id, this._image);

  String get name => _name;

  String get horario => _horario;

  String get calificacion => _id;

  String get direccion => _direccion;

  String get image => _image;

  String get id => _id;
}
