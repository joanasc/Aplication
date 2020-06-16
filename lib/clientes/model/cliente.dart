import 'package:firebase_database/firebase_database.dart';


class Cliente {
  String _id;
  String _nombre;
  String _email;
  String _contrasena;

  Cliente (this._id, this._nombre, this._email, this._contrasena);

  Cliente.map(dynamic obj) {
    this._nombre = obj['nombre'];
    this._email = obj['email'];
    this._contrasena = obj['contrasena'];
  }

  String get id => _id;
  String get nombre => _nombre;
  String get email => _email;
  String get contrasena => _contrasena;

  Cliente.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _nombre = snapshot.value['nombre'];
    _email = snapshot.value['email'];
    _contrasena = snapshot.value['contrasena'];
  }
}


