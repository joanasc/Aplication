import 'dart:async';
import 'package:BerlopAdministrador/behaviors/hiddenScrollBehavior.dart';
import 'package:BerlopAdministrador/cliente/mainC.dart';
import 'package:BerlopAdministrador/cliente/global.dart';
import 'package:BerlopAdministrador/cliente/list/usuario.dart';
import 'package:BerlopAdministrador/cliente/login/login_summary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(Login());

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginUser(title: 'Login'),
      routes: <String, WidgetBuilder>{
        '/UsuariosApp': (BuildContext context) => UsuariosApp(),
      },
    );
  }
}

class LoginUser extends StatelessWidget {
  final String title;
  LoginUser({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.blue[900],
    ));
    return Scaffold(
       resizeToAvoidBottomPadding: false,
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  loginFormState createState(){
    return loginFormState();
  }
}

class loginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,//para el teclado
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            _getContent()
          ],
        ),

      ),
    );
  }
  Container _getContent(){
    return Container(
      child: ScrollConfiguration( //para el teclado
        behavior: HiddenScrollBehavior(),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              LoginSummary(horizontal: false),
              Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 40.0),
            child:TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: 12.0,
                  height: 0.5,
                ),
                decoration: new InputDecoration(
                  labelText: "Email",
                  fillColor: Colors.white,
                  prefixIcon: Icon (Icons.email, size: 20, ),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                ),
                validator: validateEmail,
                controller: email,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 40.0),
            child:TextFormField(
                obscureText: true ,
                style: TextStyle(
                  fontSize: 12.0,
                  height: 0.5,
                ),
                decoration: new InputDecoration(
                  labelText: "Contraseña", 
                  fillColor: Colors.white,
                  prefixIcon: Icon (Icons.enhanced_encryption, size: 20, ),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                ),
                validator: validatePassword,
                controller: password,
              ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 70.0),
            child: MaterialButton(
              minWidth: 100.0,
              height: 45.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              onPressed: (){
                if (_formKey.currentState.validate()){
                  signInWithCredentials(context);
                }
              },
              color: Colors.blue[900],
              child: setUpButtonChild(),
            ),
          ),
          //para login en Google
          /*
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
            child: _signInButton(),
          ),
          //
          */
            ],
          ), 
        ),
      )
    );
  }
  String validateEmail(String value){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (value.isEmpty){
      return 'Por favor ingrese el email';
    }else{
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value)){
        return 'Ingrese un Email valido';
      }else{
        return null;
      }
    }
  }
  String validatePassword(String value){
    if (value.isEmpty) {
      return 'Por favor ingrese la contraseña';
    } else {
      if(6 > value.length){
        return 'Por favor ingrese una contraseña de 6 caracteres';
      }
    }
  }
  int _state = 0;
  Widget setUpButtonChild(){
    if(_state == 0 ){
      return new Text(
        'Iniciar sesion',
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
        'Iniciar sesion',
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
  //metodo para obtener la informacion de firebase de la seccion de autentificacion de usuarios
  void signInWithCredentials(BuildContext context){
    final _auth = FirebaseAuth.instance;
    final _db = Firestore.instance;
    animateButton();
    _auth.signInWithEmailAndPassword(
      email: email.text, 
      password: password.text,
    ).then((AuthResult user){
      Future<DocumentSnapshot> snapshot = _db.collection('Usuarios').document(email.text).get();
      snapshot.then((DocumentSnapshot user){
        Global.user = Usuario(
          user.data['Telefono'],
          user.data['Apellido'],
          user.data['Emoji'],
          user.data['Nombre'],
          user.data['Image'],
          user.documentID
        );
        Navigator.of(context).pushReplacementNamed('/UsuariosApp');
      });
      
    }).catchError((e)=>{
      setState(() {
      _state = 2;
      }),
      Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text(e.message))),
    });
  }
  //para Gloogle
  /*
  Widget _signInButton(){
    final _db = Firestore.instance;
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: (){
        googleSignIn().then((FirebaseUser user) {
          Future<DocumentSnapshot> snapshot = _db.collection('Usuarios').document(user.email).get();
          snapshot.then((DocumentSnapshot user){
            Global.user = Usuario(
              user.data['Apellido'],
              user.data['Emoji'],
              user.data['Nombre'],
              user.data['Image'],
              user.documentID
            );
            Navigator.of(context).pushReplacementNamed('/UsuariosApp');
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Gloogle',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  */
  //para google
  /*
  Future<FirebaseUser> googleSignIn() async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =  await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle();
    
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accesToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(usert.uid == currentUser.uid);
    return user;
  }
  */
}

//Habilitar la opcion de autentificacion con Google, obtener la huella digital SHA1
//agregar la huella y descargar otra vez el archivo Json, eliminar el que ya se tine y poner al nuevo