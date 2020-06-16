import 'package:BerlopAdministrador/cliente/add/add_usuario.dart';
import 'package:BerlopAdministrador/cliente/mainC.dart';
import 'package:BerlopAdministrador/cliente/menu/menu_lateral.dart';
import 'package:BerlopAdministrador/cliente/details/separator.dart';
import 'package:BerlopAdministrador/cliente/details/user_summary.dart';
import 'package:BerlopAdministrador/cliente/global.dart';
import 'package:BerlopAdministrador/cliente/list/usuario.dart';
import 'package:BerlopAdministrador/cliente/login.dart';
import 'package:flutter/material.dart';

class DetailsUsuarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Details',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: DetailsUsuario(title: 'Detalles'),
      routes: <String, WidgetBuilder>{
        '/UsuariosApp': (BuildContext context) => UsuariosApp(),
        '/Login': (BuildContext context) => Login(),
        '/AddUsuario': (BuildContext context) => AddUsuario(),
        '/DetailsUsuarios': (BuildContext context) => DetailsUsuarios(),
      },
    );
  }
  
}

class DetailsUsuario extends StatelessWidget {
  final String title;
  DetailsUsuario({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/UsuariosApp');
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Details(),
      drawer: MenuLatela(),
    );
  }
  
}

class Details extends StatefulWidget {
  @override
  DetailsFormState createState() {
    return DetailsFormState();
  }
  
}

class DetailsFormState extends State<Details> {
  Usuario _doc;
  DetailsFormState(){
    _doc = Global.doc;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xFF333366),
        child: Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
          ],
        ),
      ),
    );
  }
  Container _getBackground(){
    return Container(
      child: Image.network( _doc.Image,
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: BoxConstraints.expand(height: 295.0),
    );
  } 

  Container _getGradient() {
    return Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            new Color(0x00736AB7),
            new Color(0xFF333366),
          ],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getContent(){
    final _overviewTitle = "Cliente".toUpperCase();
    return Container(
      child: ListView(
        padding:  EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          UsuarioSummary(
            horizontal: false
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Informacion del cliente",//_overviewTitle,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Separator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}