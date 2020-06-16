import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
    
}

class _SettingsPageState extends State<SettingsPage> {

_logout() async{
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacementNamed('/welcome');

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        centerTitle: true,
      ),
      body: Center(
        child: FlatButton(
          onPressed: (){
            _logout();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Cerrar sesión', 
                style: TextStyle(
                  color: Colors.redAccent, 
                  fontSize: 30.0),),
              Spacer(),
              Icon(
                Icons.exit_to_app,
                color: Colors.redAccent,
                size: 35.0,
              )
            ],
          ),
        ),
      ),
    );
  }  
}