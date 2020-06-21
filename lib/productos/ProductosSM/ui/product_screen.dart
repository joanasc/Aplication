import 'package:BerlopAdministrador/productos/ProductosSM/model/product.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

//para las imaganes
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';

File image;
String filename;

class ProductScreen extends StatefulWidget {
  final Product product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

final productReference = FirebaseDatabase.instance.reference().child('product');

class _ProductScreenState extends State<ProductScreen> {
  List<Product> items;

  TextEditingController _nameController;
  TextEditingController _codebarController;
  TextEditingController _descriptionController;
  TextEditingController _priceController;
  TextEditingController _stockController;

  //nuevo imagen
  String productImage;

  ///Path of newly uploaded image
  var uploadedImagePath;

  pickerCam() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

  pickerGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

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
    _nameController = new TextEditingController(text: widget.product.name);
    _codebarController =
        new TextEditingController(text: widget.product.codebar);
    _descriptionController =
        new TextEditingController(text: widget.product.description);
    _priceController = new TextEditingController(text: widget.product.price);
    _stockController = new TextEditingController(text: widget.product.stock);
    productImage = widget.product.productImage;
    print(productImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Actualizar producto'),
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
                  children: <Widget>[
                    new Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.blueAccent)),
                      padding: new EdgeInsets.all(5.0),
                      child: image == null ? Text('Añadir') : Image.file(image),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.2),
                      child: new Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: new BoxDecoration(
                            border: new Border.all(color: Colors.blueAccent)),
                        padding: new EdgeInsets.all(5.0),
                        child: productImage == null
                            ? Text('Editar')
                            : Image.network(productImage),
                      ),
                    ),
                    Divider(),
                    //nuevo para llamar imagen de la galeria o capturarla con la camara
                    new IconButton(
                        icon: new Icon(Icons.camera_alt), onPressed: pickerCam),
                    Divider(),
                    new IconButton(
                        icon: new Icon(Icons.image), onPressed: pickerGallery),
                  ],
                ),
                TextField(
                  controller: _nameController,
                  style: TextStyle(fontSize: 17.0, color: Colors.blueAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.local_laundry_service),
                      labelText: 'Nombre'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _codebarController,
                  style: TextStyle(fontSize: 17.0, color: Colors.blueAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.check_box_outline_blank),
                      labelText: 'Disponibles'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _descriptionController,
                  style: TextStyle(fontSize: 17.0, color: Colors.blueAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.reorder), labelText: 'Descripción'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _priceController,
                  style: TextStyle(fontSize: 17.0, color: Colors.blueAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.monetization_on), labelText: 'Precio'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                ),
                Divider(),
                TextField(
                  controller: _stockController,
                  style: TextStyle(fontSize: 17.0, color: Colors.blueAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.shopping_basket),
                      labelText: 'Existencias'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                ),
                Divider(),
                FlatButton(
                    onPressed: () async {
                      //nuevo imagen
                      if (widget.product.id != null) {
                        var now = formatDate(
                            new DateTime.now(), [yyyy, '-', mm, '-', dd]);
                        var fullImageName =
                            '${_nameController.text}-$now' + '.jpg';

                        if (image != null) {
                          final StorageReference ref = FirebaseStorage.instance
                              .ref()
                              .child(fullImageName);

                          final StorageUploadTask task = ref.putFile(image);

                          print("Picture uploading...");

                          task.onComplete.then((value) async{
                            uploadedImagePath = await value.ref.getDownloadURL();

                            print("Picture uploaded successfully");
                            productReference.push().set({
                              'name': _nameController.text,
                              'codebar': _codebarController.text,
                              'description': _descriptionController.text,
                              'price': _priceController.text,
                              'stock': _stockController.text,
                              'ProductImage': uploadedImagePath //nuevo imagen
                            }).then((_) {
                               Navigator.pop(context);
                              print("Done");
                            });
                          });
                        } else {
                          productReference.push().set({
                            'name': _nameController.text,
                            'codebar': _codebarController.text,
                            'description': _descriptionController.text,
                            'price': _priceController.text,
                            'stock': _stockController.text,
                            'ProductImage': null //nuevo imagen
                          }).then((_) {
                            Navigator.pop(context);
                          });
                        }
                      }
                    },
                    child: (widget.product.id != null)
                        ? Text('Actualizar')
                        : Text('Agregar')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
