import 'package:BerlopAdministrador/behaviors/hiddenScrollBehavior.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
 
  String _email;
  String _password;

  bool _isRegistering = false;

  _register() async {
    if (_isRegistering) return;
    setState(() {
      _isRegistering = true;
    });

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Usuario registrado'),
    ));

    final form = _formKey.currentState;

    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _isRegistering = false;
      });
      return;
    }

    form.save();

    try {
      await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pushReplacementNamed('/maintabs');
    } catch (e) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.message), //LA CONTRASEÑA TIENE QUE SER DE 6 CARACTERES
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
        _isRegistering = false;
      });
    }

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Registro de clientes'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ScrollConfiguration(
          behavior: HiddenScrollBehavior(),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                FlutterLogo(
                  style: FlutterLogoStyle.markOnly,
                  size: 200.0,
                ),
                TextFormField(
                  autocorrect: false, 
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
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
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Contraseña'),
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
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Bienvenidos a Todos App!',
                    style: 
                      TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
                  ),
                )
              ],
            ),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _register();
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}

