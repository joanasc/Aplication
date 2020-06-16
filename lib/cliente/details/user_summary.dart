import 'package:BerlopAdministrador/cliente/add/add_usuario.dart';
import 'package:BerlopAdministrador/cliente/list/usuario.dart';
import 'package:BerlopAdministrador/cliente/details/separator.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class UsuarioSummary extends StatelessWidget {
  final bool horizontal;
  Usuario _doc;
  UsuarioSummary({this.horizontal}){
    _doc = Global.doc;
  }

  @override
  Widget build(BuildContext context) {
    final imageThumbnail = Container(
      margin: EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,//para alinear dependiando de lo que contenga
      child: Container(
        height: 90.0,
        width: 90.0,
        decoration: BoxDecoration(
          color: Colors.pink,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(50.0),
          image: DecorationImage(
            image: NetworkImage(_doc.Image),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            new BoxShadow(
              color: Color(0xffA4A4A4),
              offset: Offset(1.0, 5.0),
              blurRadius: 3.0,
            ),
          ],
        ),
      ),
    );


    Widget _userValue({String value, IconData icono}){
      return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children:<Widget>[
            Icon(icono,color: Colors.white,size: 15.0,),
            Container(width: 8.0),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    final userCardContent = Container(
      margin: EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          Container( height: .0),
          Text(
            "${_doc.Nombre} ${_doc.Apellido}",
            style: TextStyle(
              fontSize: 18,
              color:Colors.white,
            ),
          ),
          Separator(),
          Container(height: 15.0),
          //Text("${_doc.Emoji}"),//vista del emoji
          /*Text(
            "Tel: ${_doc.Telefono}",
            style: TextStyle(
              fontSize: 14,
              color:Colors.white,
            ),
          ),*/
          Expanded(
                flex: horizontal ? 1 : 0,
                child: _userValue(
                  value:_doc.Telefono,
                  icono: Icons.phone)
              ),
          Container(height: 10.0),
          //Separator(),//lienea azul
          //Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            //children: <Widget>[
              Expanded(
                flex: horizontal ? 1 : 0,
                child: _userValue(
                  value:_doc.Email,
                  icono: Icons.email)
              ),
              Container(
                width: 32.0,
              ),
            //],
          //),
        ],
      ),
    );
    final userCard = Container(
      child: userCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
        ? EdgeInsets.only(left: 46.0)
        : EdgeInsets.only(top: 72.0),
      decoration: BoxDecoration(
        color: Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
    );
    return InkWell(
      onTap: () => Navigator.of(context).push(
        new PageRouteBuilder(
          pageBuilder: (_, __, ___) => new AddUsuario(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => 
          new FadeTransition(opacity: animation, child: child),
        )
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[  
            userCard,          
            imageThumbnail
          ]
        ),
      ),
    );
  } 
  
}