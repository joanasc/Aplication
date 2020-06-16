import 'package:flutter/material.dart';

class PedidosC extends StatefulWidget {
  @override
  _PedidosCState createState() => _PedidosCState();
}

class _PedidosCState extends State<PedidosC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Text(
          "AQUI DEBEN DE APARECER LOS PEDIDOS DE LOS CLIENTES",
          textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}