import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.blue[900], BlendMode.hardLight),
          image: AssetImage("assets/images/welcome.jpeg"),
          fit: BoxFit.cover,
        ),
        //color: Colors.white, 
        //borderRadius: BorderRadius.circular(50.0),
      ),
      
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top:160.0),),
            Text(
              'Bienvenido',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                //fontWeight: FontWeight.w900,
                //fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
                fontFamily: 'ArchivoBlack',
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0),),
            Text(
              'P E D I D O S   A L  I N S T A N T E',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
              )
            ),
            Padding(padding: EdgeInsets.only(top:50.0)),
            Padding(padding: const EdgeInsets.all(30.0),),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.orangeAccent,
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
              child: Text('INGRESAR',
                style: TextStyle(
                  fontSize: 20, 
                  color: Colors.white, 
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top:70.0)),
            SizedBox(
              height: 50,
              child: Image.asset('assets/images/welcome2.png')
            ),
          ],
        ),
      ),
    );
  }
}
/*
textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                ),
                padding: const EdgeInsets.all(10.0),
                
                child:
                    const Text('Administrador', style: TextStyle(fontSize: 20)),
              ),
              */
