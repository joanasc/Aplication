import 'package:BerlopAdministrador/behaviors/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
 
  String _email;
  String _password;

  bool _isLoggingIn= false;

  _login() async {
    if (_isLoggingIn) return;
    setState(() {
      _isLoggingIn = true;
    });

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Iniciando sesión'),
    ));

    final form = _formKey.currentState;

    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isLoggingIn = false;
      });
      return;
    }

    form.save();


    try {
      await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/maintabs');
    } catch (e) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('El email o la contraseña son incorrectos, intentelo de nuevo'), //LA CONTRASEÑA TIENE QUE SER DE 6 CARACTERES
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'Descartar',
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
      ));
    } finally {
      setState(() {
        _isLoggingIn = false;
      });
    }

    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: Center(
        child: Container(
          height: 900,
          width: 900,
          //padding: EdgeInsets.all(60.0),
          padding: EdgeInsets.symmetric(vertical: 110, horizontal: 40),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fondofondo3.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              //border: Border.all( //bordes
                //color: Colors.black,
                //width: 2,
              //),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  //offset: Offset(5, 5),
                  blurRadius: 4
                )
              ]
            ),
            height: 300,
            width: 300,
            padding: EdgeInsets.only(right: 20.0, left: 20.0),
            child: ScrollConfiguration(
              behavior: HiddenScrollBehavior(),
              child: new Theme(
                data: new ThemeData(
                  hintColor: Colors.grey,//para la letra
                  primaryColor: Colors.blue[900],
                  primaryColorDark: Colors.orangeAccent,
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.all(1.0),),
                      Text(
                        ('Iniciar sesión'),
                        style: TextStyle(
                          fontSize: 20, 
                          color: Color(0xff0F3455), 
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(padding: EdgeInsets.only(top:30.0)),
                      TextFormField(
                        autocorrect: false, 
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          contentPadding: new EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                          //fillColor: Colors.orangeAccent,
                          prefixIcon: Icon(
                            Icons.email, 
                            color: Colors.orangeAccent,
                            size: 18,
                          ), 
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff24429C), width: 2),
                            borderRadius: new BorderRadius.circular(15.0),
                          ),  
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            borderSide: new BorderSide(color: Colors.blue[900]),
                          ),
                        ),
                        style: TextStyle(fontSize: 12,height: 0.1,),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Por favor ingresa un correo valido';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) {
                          setState(() {
                            _email = val;
                          });
                        },
                      ),
                      Padding(padding: EdgeInsets.only(top:15.0)),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          contentPadding: new EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                          prefixIcon: Icon(
                            Icons.lock, 
                            color: Colors.orangeAccent,
                            size: 18,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff24429C), width: 2),
                            borderRadius: new BorderRadius.circular(15.0),
                          ), 
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            borderSide: new BorderSide(color: Colors.blue[900],
                            ),
                          ),
                        ),
                        style: TextStyle(fontSize: 12, height: 0.1,),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Por favor ingresa la contraseña correcta';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) {
                          setState(() {
                            _password = val;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        //child: Text(
                          //'Bienvenidos a Berlop App!',
                          //style: 
                            //TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
                          //textAlign: TextAlign.center
                        //),
                      ),
                      FlatButton(
                        child: Text("¿Olvidaste tu contraseña?",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed("/forgotpassword"); 
                        },
                        textColor: Colors.blueGrey,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Color(0xff24429C),
                          onPressed: () {
                            _login();
                          },
                          //padding: EdgeInsets.only(right: 30.0, left: 30.0),
                          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
                          //padding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 0.5),
                          child: Text('Iniciar sesión',
                            style: TextStyle(
                              fontSize: 18, 
                              color: Colors.white, 
                              fontWeight: FontWeight.w800,
                            ), 
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          )
        ),
      ),
      //floatingActionButton: FloatingActionButton(
        //onPressed: () {
          //_login();
        //},
        //child: Icon(Icons.account_circle),
      //),
      /*persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/register"); 
          },
            child: Text('Ir a registrar'),
        )
      ],*/
    );
  }
}