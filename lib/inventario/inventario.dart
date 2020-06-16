import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InventarioP extends StatefulWidget {
  @override
  _InventarioPState createState() => _InventarioPState();
}

class _InventarioPState extends State<InventarioP> {

  _logout() async{
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacementNamed('/welcome');

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventario'),
        centerTitle: true,
      ),
      body: Center(
        child: Text("AQUI DEBEN DE REGISTRARSE TODOAS LAS EXISTENCIAS DE PRODUCTOS", 
          textAlign: TextAlign.center,
        ),  
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _logout();
        },
        child: Icon(Icons.exit_to_app, color: Colors.white,),
      ),
    );
  }
}