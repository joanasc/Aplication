import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:BerlopAdministrador/clientes/model/cliente.dart';

String filename;

class ClienteScreen extends StatefulWidget {
  final Cliente cliente;
  ClienteScreen(this.cliente);
  @override
  _ClienteScreenState createState() => _ClienteScreenState();
}

final productReference = FirebaseDatabase.instance.reference().child('cliente');

class _ClienteScreenState extends State<ClienteScreen> {

  List<Cliente> items;

  TextEditingController _nombreController;
  TextEditingController _emailController;
  TextEditingController _contrasenaController;
  
  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }
  //fin nuevo imagen

  @override
  void initState() {
    super.initState();
    _nombreController = new TextEditingController(text: widget.cliente.nombre);
    _emailController = new TextEditingController(text: widget.cliente.email);
    _contrasenaController = new TextEditingController(text: widget.cliente.contrasena);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Actualizar clientes'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
       
        //height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                ),
                TextField(
                  controller: _nombreController,
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.blueAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.local_laundry_service), labelText: 'Nombre'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                ),
                Divider(),
                FlatButton(
                    onPressed: () {
                      if (widget.cliente.id != null) {

                        productReference.child(widget.cliente.id).set({
                          'nombre': _nombreController.text,
                          'email': _emailController.text,
                          'contrasena': _contrasenaController.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      } else {
                        productReference.push().set({
                          'nombre': _nombreController.text,
                          'email': _emailController.text,
                          'contrasena': _contrasenaController.text,
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: (widget.cliente.id != null)
                        ? Text('Update')
                        : Text('Add')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

