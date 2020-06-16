import 'package:BerlopAdministrador/cliente/mainC.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:BerlopAdministrador/cliente/add/add_usuario.dart';

import '../global.dart';

class MenuLatela extends StatefulWidget {
  @override
  Menu createState() {
    return Menu();
  }
}

class Menu extends State<MenuLatela> {
  final _auth = FirebaseAuth.instance;
  //GoogleSignIn _googleSignIn = GoogleSignIn();//para google
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader( 
              child:Text(
                '${Global.user.Nombre} ${Global.user.Apellido}',
                style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                //sombra al nombre del usuario
                shadows: [
                  new BoxShadow(
                    color: Color(0xffA4A4A4),
                    offset: Offset(1.0, 5.0),
                    blurRadius: 3.0,
                  )
                ]
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: NetworkImage(Global.user.Image), 
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffA4A4A4),
                    offset: Offset(1.0, 5.0),
                    blurRadius: 3.0,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: new Icon(
                Icons.home,
                color: Color(0xff222222),
              ),
              title: Text('Inicio'),
              onTap: () => Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_,__,___) => new UsuariosApp(),
                )),
            ),
            ListTile(
              leading: new Icon(
                Icons.person,
                color: Color(0xff222222),
              ),
              title: Text('Registrar cliente'),
              onTap: () => 
              {
                Global.doc = null,
                Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_,__,___) => new AddUsuario(),
                ),),
              }
            ),
            ListTile(
              leading: new Icon(
                Icons.close,
                color: Color(0xff222222),
              ),
              title: Text('Cerrar sesion'),
              onTap: () => 
              {
                Global.doc = null,
                Global.user = null,
                signOut(),
                Navigator.of(context).pushReplacementNamed('/Login'),
              }
            ),
            ListTile(
              leading: new Icon(
                Icons.delete_forever,
                color: Color(0xff222222),
              ),
              title: Text('Eliminar cliente'),
              onTap: () async {  
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  user.delete(); //este es el indicado para ELIMINAAAAAAR
                  //await AuthService().deleteUser(card(Usuario.));
                  //await AuthService().deleteUser(email, password);
                }
            ),
          ],
        ),
      );
  }
  Future<void> signOut() async{
    return Future.wait([
      _auth.signOut()
      //_googleSignIn.signOut()  //para google
    ]);
  }
}