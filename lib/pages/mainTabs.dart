import 'package:BerlopAdministrador/inventario/inventario.dart';
import 'package:BerlopAdministrador/cliente/login.dart';
//import 'package:BerlopAdministrador/pages/settings.dart';
import 'package:BerlopAdministrador/pedidos/pedidos.dart';
import 'package:BerlopAdministrador/productos/productosCMySM.dart';
import 'package:flutter/material.dart';

class MainTabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 4,
      child: new Scaffold(
        body: TabBarView(
          children: <Widget>[Login(), ProductosCMySM(), PedidosC(), InventarioP(), /*SettingsPage(), ClienteP()*/],
        ),
        bottomNavigationBar: PreferredSize(
          preferredSize: Size(60.0, 60.0),
          child: Container(
            height: 60.0,
            child: TabBar(
              labelColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(fontSize: 9.0),
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.people_outline),
                  text: 'Clientes',
                ),
                Tab(
                  icon: Icon(Icons.dashboard),
                  text: 'Productos',
                ),
                Tab(
                  icon: Icon(Icons.shopping_basket),
                  text: 'Pedidos',
                ),
                Tab(
                  icon: Icon(Icons.format_list_bulleted),
                  text: 'Inventario',
                ),
                /*Tab(
                  icon: Icon(Icons.settings),
                  text: 'Ajustes',
                ),
                Tab(
                  icon: Icon(Icons.dashboard),
                  text: 'Product Cli',
                ),*/
              ],
            )
          ),
        ),
      ),
    ));
  }
  
}