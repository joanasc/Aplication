import 'dart:async';
import 'package:BerlopAdministrador/cliente/mainC.dart';
import 'package:BerlopAdministrador/cliente/details/details_user.dart';
import 'package:BerlopAdministrador/cliente/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../global.dart';
import 'card_foto.dart';
import 'package:flutter/material.dart';
import 'package:BerlopAdministrador/cliente/menu/menu_lateral.dart';
void main () => runApp(AddUsuario());

class AddUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registrar',
      theme: ThemeData(//primarySwatch: Colors.teal,
          backgroundColor: Colors.blueAccent,
      ),
      home: HomePage(title: 'Registrar y Actualizar'),
      routes: <String, WidgetBuilder>{
        '/UsuariosApp': (BuildContext context) => UsuariosApp(),
        '/Login': (BuildContext context) => Login(),
        '/AddUsuario': (BuildContext context) => AddUsuario(),
        '/DetailsUsuarios': (BuildContext context) => DetailsUsuarios(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  HomePage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(title),centerTitle: true,
        actions: <Widget>[
          InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/UsuariosApp');
            },
          ),
          SizedBox(width: 10),
        ],
        ),
      body: UsuarioForm(),
      drawer: MenuLatela(),
    );
  }
}
//AQUI EMPIESA EL FORMULARIO
class UsuarioForm extends StatefulWidget {
  @override
  UsuarioFormState createState() {
    return UsuarioFormState();
  }
}

class UsuarioFormState extends State<UsuarioForm> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var nombre = TextEditingController();
  var apellido = TextEditingController();
  var telefono = TextEditingController();
  List _emoji = ["🥺","🥰","😡","🙎","😊"];//para la lista de emiois
  List<DropdownMenuItem<String>> _dropDownMenuItems;//para la lista de emiois
  String _currentEmoji, _image;//para la lista de emiois
  bool _isEnabled = true;//esto se desabilita para poder cambiar la contraseña y el email
  @override
  void initState() { 
    _dropDownMenuItems = getDropDownMenuItems();
    _currentEmoji = _dropDownMenuItems[0].value;
    _image = null;
    _isEnabled = true;//esto se desabilita para poder cambiar la contraseña y el email
    if (Global.doc != null){
      nombre.text = Global.doc.Nombre;
      apellido.text = Global.doc.Apellido;
      telefono.text = Global.doc.Telefono;
      email.text = Global.doc.Email; //email.text = Global.doc.data['Email'];
      _currentEmoji = Global.doc.Emoji;
      _image = Global.doc.Image;
      password.text = "*******";
      _isEnabled = false;//esto se desabilita para poder cambiar la contraseña y el email
    }
    super.initState();
  }

  @override
Widget build(BuildContext context) {
  return Form(
    key: _formKey,
    child: ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 10.0),
          child:CardFotos(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
          child:TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 20.0),
            decoration: new InputDecoration(
              labelText: "Nombre",
              fillColor: Colors.white,
              prefixIcon: Icon (Icons.person ),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
            ),
            // ignore: missing_return
            validator: (value){
              if (value.isEmpty){
                return 'Por favor ingrese el nombre';
              }
            },
            controller: nombre,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
          child:TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 20.0),
            decoration: new InputDecoration(
              labelText: "Apellido",
              fillColor: Colors.white,
              prefixIcon: Icon (Icons.person ),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
            ),
            // ignore: missing_return
            validator: (value){
              if (value.isEmpty){
                return 'Por favor ingrese el apellido';
              }
            },
            controller: apellido,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
          child:TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 20.0),
            decoration: new InputDecoration(
              labelText: "Numero",
              fillColor: Colors.white,
              prefixIcon: Icon (Icons.phone ),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(
                ),
              ),
            ),
            // ignore: missing_return
            validator: (value){
              if (value.isEmpty){
                return 'Por favor ingrese el telefono';
              }
            },
            controller: telefono,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
          child:TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 20.0),
              decoration: new InputDecoration(
                labelText: "Email",
                fillColor: Colors.white,
                prefixIcon: Icon (Icons.email ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              validator: validateEmail,
              controller: email,
              enabled: _isEnabled,//esto se desabilita para poder cambiar la contraseña y el email
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
          child:TextFormField(
              obscureText: true ,
              style: TextStyle(fontSize: 20.0),
              decoration: new InputDecoration(
                labelText: "Contraseña",
                fillColor: Colors.white,
                prefixIcon: Icon (Icons.enhanced_encryption ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              validator: validatePassword,
              controller: password,
              enabled: _isEnabled,//esto se desabilita para poder cambiar la contraseña y el email
            ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
          child:DropdownButton(
            value: _currentEmoji,
            items: _dropDownMenuItems,
            onChanged: changedDropDownItem,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10.0),
          child: MaterialButton(
            minWidth: 200.0,
            height: 60.0,
            onPressed: (){
              if (_formKey.currentState.validate()){
                if(Global.doc == null) {
                  registrar(context);
                } else {
                  actualizar();
                }
              }
            },
            color: Colors.lightBlue,
            child: setUpButtonChild(),
          ),
        ),
      ],
    ),
  );
}
  //PARA LA LISTA DE EMOJIS
  List<DropdownMenuItem<String>> getDropDownMenuItems(){
    List<DropdownMenuItem<String>> items = new List();
    for (String item in _emoji) {
      items.add( new DropdownMenuItem(
        value: item,
        child: new Text(
          item,
          style: TextStyle(
            fontSize: 35,
          ),
        ),
      )
      );
    }
    return items;
  }
  void changedDropDownItem(String selectEmoji) {
    setState(() {
      _currentEmoji = selectEmoji;
    });
  }
  //metodo para verificar si el email es correcto y valido
  String validateEmail(String value){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (value.isEmpty){
      return 'Por favor ingrese el email';
    }else{
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value)){
        return 'Enter un Email valido';
      }else{
        return null;
      }
    }
  }
  //verificar si la contrsaeña es mayor de 6 caracteres
  String validatePassword(String value){
    if (value.isEmpty) {
      return 'Por favor ingrese el password';
    } else {
      if(6 > value.length){
        return 'Por favor ingrese una password de 6 caracteres';
      }
    }
  }
  int _state = 0;
  Widget setUpButtonChild(){
    if(_state == 0 ){
      return new Text(
        'Aplicar',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    } else if(_state == 1){
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return new Text(
        'Registrar',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    }
  }

  void animateButton(){
    setState(() {
      _state = 1;
    });
    Timer(Duration(seconds: 20),(){
      setState(() {
      _state = 2;
      });
    });
  }

  registrar(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    final _firebaseStorageRef = FirebaseStorage.instance;
    final _db = Firestore.instance;
    var image = CardFoto.galleryFile;
    if(image != null){
      setState(() {
        if (_state == 0) {
          animateButton();        
        }
      });
      await _auth.createUserWithEmailAndPassword(
        email: email.text, 
        password: password.text,
      ).then((AuthResult user) async{
        final StorageUploadTask task = _firebaseStorageRef.ref().child("Usuarios").child("${email.text}").putFile(image);
        if (await task.onComplete !=null){
          StorageTaskSnapshot storageTaskSnapshot = await task.onComplete;
          String imgUrl = await storageTaskSnapshot.ref.getDownloadURL();
          DocumentReference ref = _db.collection('Usuarios').document(email.text);
          ref.setData({
            'Nombre': '${nombre.text}', 
            'Apellido': '${apellido.text}',
            'Telefono': '${telefono.text}',
            'Emoji': '$_currentEmoji', 
            'Image': '$imgUrl'}).then((onValue) {
              Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder:(_,__,___) => new HomePageMain()
              ));
          });
        }
      }).catchError((e)=>{
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(e.message))),
      });
    }
  }

  actualizar() async {
    
    final _firebaseStorageRef = FirebaseStorage.instance;
    final _db = Firestore.instance;
    var image = CardFoto.galleryFile;
    DocumentReference ref = _db.collection('Usuarios').document(email.text);
      setState(() {
        if (_state == 0) {
          animateButton();        
        }
      });
    if(image != null){
      final StorageUploadTask task = _firebaseStorageRef.ref().child("Usuarios")
        .child("${email.text}").putFile(image);
      if (await task.onComplete != null){
        StorageTaskSnapshot storageTaskSnapshote = await task.onComplete;
        String imgUrl = await storageTaskSnapshote.ref.getDownloadURL();
        ref.setData({
          'Nombre': '${nombre.text}',
          'Apellido': '${apellido.text}',
          'Telefono': '${telefono.text}',
          'Emoji': '$_currentEmoji',
          'Image': '$imgUrl'
        }).then((onValue){
          Navigator.of(context).pushReplacementNamed('/UsuariosApp');
        });
      }
    } else {
      if(_image != null){
        ref.setData({
          'Nombre': '${nombre.text}',
          'Apellido': '${apellido.text}',
          'Telefono': '${telefono.text}',
          'Emoji': '$_currentEmoji',
          'Image': '$_image'
        }).then((onValue){
          Navigator.of(context).push(new PageRouteBuilder(
            pageBuilder: (_, __, ___) => new HomePageMain()
            ));
        });
      } else{
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Seleccione una imagen')));
      }
    }
  }
}