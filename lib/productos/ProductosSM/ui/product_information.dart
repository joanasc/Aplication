import 'package:BerlopAdministrador/productos/ProductosSM/model/product.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductInformation extends StatefulWidget {
  final Product product;
  ProductInformation(this.product);
  @override
  _ProductInformationState createState() => _ProductInformationState();
}

final productReference = FirebaseDatabase.instance.reference().child('product');

class _ProductInformationState extends State<ProductInformation> {

  List<Product> items;

  String productImage;//nuevo

  @override
  void initState() {   
    super.initState();
    productImage = widget.product.productImage;//nuevo
    print(productImage);//nuevo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información del Producto'),
        backgroundColor: Colors.blueAccent,
      ),
      //resizeToAvoidBottomPadding: false,
      body: Container(
        height: 800.0,
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(//para la franja amarilla- error de pixeles
          child: Card(
            child: Center(
              child: Column(
                children: <Widget>[                
                  new Text("Nombre : ${widget.product.name}", style: TextStyle(fontSize: 18.0),),
                  Padding(padding: EdgeInsets.only(top: 8.0),),
                  Divider(),
                  new Text("Disponible : ${widget.product.codebar}", style: TextStyle(fontSize: 18.0),),
                  Padding(padding: EdgeInsets.only(top: 8.0),),
                  Divider(),
                  new Text("Descripción : ${widget.product.description}", style: TextStyle(fontSize: 18.0),),
                  Padding(padding: EdgeInsets.only(top: 8.0),),
                  Divider(),
                  new Text("Precio : \$${widget.product.price}", style: TextStyle(fontSize: 18.0),),
                  Padding(padding: EdgeInsets.only(top: 8.0),),
                  Divider(),
                  new Text("Existencias : ${widget.product.stock}", style: TextStyle(fontSize: 18.0),),
                  Padding(padding: EdgeInsets.only(top: 8.0),),
                  Divider(),
                  Container(
                            height: 300.0,
                            width: 300.0,
                child: Center(
                  child: productImage == ''
                      ? Text('No hay Imagen')
                      : Image.network(productImage+'?alt=media'),//nuevo para traer la imagen de firestore
                ),
              ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}