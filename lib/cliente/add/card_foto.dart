import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../global.dart';

class CardFotos extends StatefulWidget {
  @override
  CardFoto createState() {
    return CardFoto();
  }
}

class CardFoto extends State<CardFotos> {
  static File galleryFile;
  static Future<File> imageFile;
  //para poder asignar una nueva imagen 
  @override
  void initState(){
    imageFile = null;
    super.initState();
  }

  //funcion para obtener la imagen de la galeria del dispositivo
  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }
  //metodo para poder ver la imagen en la tarjeta
  Widget showImage(){
    if (imageFile == null) { 
      if(Global.doc != null){
        setState(() {});
        return Image.network(Global.doc.Image);
      } else {
        return image();
      }
    } else {
      return image();
    }
  }
  FutureBuilder<File>image(){
     return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot){
        if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data != null){
            galleryFile = snapshot.data;
            return Image.file(
              snapshot.data,
              width: 300,
              height: 300,
            );
          } else if (snapshot.error != null){
            return const Text(
              'Error al seleccionar la imagen',
              textAlign: TextAlign.center,
            );
          } else {
            return Image.asset("assets/images/logoBerlop.jpeg");
          }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,//sombra en la orilla de la tarjeta
      borderRadius: new BorderRadius.circular(10.0),
      child: InkWell(
        onTap: () => pickImageFromGallery(ImageSource.gallery),
        child: Container(
          height: 200,
          width: 200,
          child: showImage(),
        ),
      ),
    );
  } 
}