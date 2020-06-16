import 'package:BerlopAdministrador/cliente/add/add_usuario.dart';
import 'package:BerlopAdministrador/cliente/list/list_user.dart';
import 'package:BerlopAdministrador/cliente/details/details_user.dart';
import 'package:flutter/material.dart';

import 'login.dart';

/*
void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
      title: 'Usuarios',
      theme: ThemeData(
          //primarySwatch: Colors.teal,
          backgroundColor: Colors.blueAccent,
      ),
      home: new HomePageMain(),
  ),
);
*/

class UsuariosApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Usuarios',
      theme: ThemeData(
          //primarySwatch: Colors.teal,
          backgroundColor: Colors.blueAccent,
      ),
      home: HomePageMain(),
      routes: <String, WidgetBuilder>{
        '/UsuariosApp': (BuildContext context) => UsuariosApp(),
        '/Login': (BuildContext context) => Login(),
        '/AddUsuario': (BuildContext context) => AddUsuario(),
        '/DetailsUsuarios': (BuildContext context) => DetailsUsuarios(),
      },
    );
  }
}

class HomePageMain extends StatefulWidget{
  @override
  _SearchListState createState() => new _SearchListState();

}

class _SearchListState extends State<HomePageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new ListUser(),
    );
  }
  
}