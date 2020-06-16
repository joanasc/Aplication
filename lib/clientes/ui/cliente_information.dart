import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:BerlopAdministrador/clientes/model/cliente.dart';


class ClienteInformation extends StatefulWidget {
  final Cliente cliente;
  ClienteInformation(this.cliente);
  @override
  _ClienteInformationState createState() => _ClienteInformationState();
}

final clienteReference = FirebaseDatabase.instance.reference().child('cliente');

class _ClienteInformationState extends State<ClienteInformation> {

  List<Cliente> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información del cliente'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        height: 800.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[                
                new Text("Nombre : ${widget.cliente.nombre}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Email : ${widget.cliente.email}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Contraseña : ${widget.cliente.contrasena}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}