//este archivo es para que los clientes puedan realizar sus compras
import 'package:BerlopAdministrador/productos/ProductosSM/model/product.dart';
import 'package:BerlopAdministrador/productos/ProductosSM/ui/product_information.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'dart:async';
//import 'package:BerlopAdministrador/productos/ui/product_screen.dart';

class ClienteP extends StatefulWidget {
  @override
  _ClientePState createState() => _ClientePState();
}

final productReference = FirebaseDatabase.instance.reference().child('product');

class _ClientePState extends State<ClienteP> {
  List<Product> items;
  //StreamSubscription<Event> _onProductAddedSubscription;
  //StreamSubscription<Event> _onProductChangedSubscription;

  @override
  void initState() {
    super.initState();
    items = new List();
    //_onProductAddedSubscription =
      //  productReference.onChildAdded.listen(_onProductAdded);
    //_onProductChangedSubscription =
        //productReference.onChildChanged.listen(_onProductUpdate);
  }

  /*
  @override
  void dispose() {
    super.dispose();
    _onProductAddedSubscription.cancel();
    _onProductChangedSubscription.cancel();
  }
  */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de productos'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,          
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.only(top: 3.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(
                      height: 1.0,
                    ),                    
                    Container(
                      padding: new EdgeInsets.all(3.0),
                      child: Card(                      
                        child: Row(
                          children: <Widget>[
                            //nuevo imagen
                             new Container( 
                              padding: new EdgeInsets.all(5.0),                          
                              child: '${items[position].productImage}' == ''
                                  ? Text('No hay imagen')
                                  : Image.network(
                                      '${items[position].productImage}' +
                                          '?alt=media',
                                          fit: BoxFit.fill,
                                      height: 57.0,
                                      width: 57.0,
                                    ),
                            ),
                            Expanded(
                              child: ListTile(
                                  title: Text(
                                    '${items[position].name}',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${items[position].description}',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                  //te permite actualizar o agragar productos
                                  //onTap: () => _navigateToProductInformation(
                                    //  context, items[position])
                                      ),
                            ),
                            //boton de eliminar
                            /*
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _showDialog(context, position),
                                ),
                                */
                            //onPressed: () => _deleteProduct(context, items[position],position)),
                            IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () =>
                                    _navigateToProduct(context, items[position])),
                          ],
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
        ),
        //botton para crear un nuevo poroducto
        /*
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blueAccent,
          onPressed: () => _createNewProduct(context),
        ),
        */
      ),
    );
  }

  //nuevo para que pregunte antes de eliminar un registro
  /*
  void _showDialog(context, position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('¿Estás seguro de que quieres eliminar este artículo?'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.purple,
                ),
                onPressed: () =>
                  _deleteProduct(context, items[position], position,),                                        
                    ),                   
            new FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  */
  /*
  //
  void _onProductAdded(Event event) {
    setState(() {
      items.add(new Product.fromSnapShot(event.snapshot));
    });
  }
  */
  //boton para actualizar producto
  /*
  void _onProductUpdate(Event event) {
    var oldProductValue =
        items.singleWhere((product) => product.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldProductValue)] =
          new Product.fromSnapShot(event.snapshot);
    });
    }
    */
  //boton para eliminar producto
  /*
  void _deleteProduct(
      BuildContext context, Product product, int position) async {
    await productReference.child(product.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
        Navigator.of(context).pop();
      });
    });
  }
  */
  //permite actualizar o agragar procutos
  /*
  void _navigateToProductInformation(
      BuildContext context, Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductScreen(product)),
    );
  }
  */
  void _navigateToProduct(BuildContext context, Product product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductInformation(product)),
    );
  }
  //para crear un nuevo producto
  /*
  void _createNewProduct(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ProductScreen(Product(null, '', '', '', '', '', ''))),
    );
  }
  */
  
}