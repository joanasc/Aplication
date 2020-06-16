import 'package:flutter/material.dart';

class ProductosCM extends StatefulWidget {
  @override
  _ProductosCMState createState() => _ProductosCMState();
}

class _ProductosCMState extends State<ProductosCM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        centerTitle: true,
      ),
      body: Container(child: Text('Hola again'),)
      /*Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: EdgeInsets.all(20.0),
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue[900],
              ), 
            ),
          ),
          Center(
            child: Container(
              width: 400, 
              height: 490,
              //color: Colors.blue,
              child: GridView.count(
              padding: EdgeInsets.only(left:65.0, right:65.0),
              crossAxisCount: 1,
              children: <Widget>[
                Muestra(
                  child: RaisedButton(
                    color: Colors.blue[900],
                    child: Text('Productos', style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/productossm"); 
                    },
                  ),
                  text: 'Productos para clientes sin mayoreo',
                ),
                Muestra(
                  child: RaisedButton(
                    color: Colors.blue[900],
                    child: Text('Productos', style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/productoscm"); 
                    },
                  ),
                  text: 'Productos para clientes con mayoreo',
                ),
              ],
            ),
            ),
          )
        ]
      ),*/
    );
  }
}
/*
class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height-50);
    var controllPoint = Offset(50, size.height);
    var endPoint = Offset(size.width/2, size.height);
    path.quadraticBezierTo(controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}


class Muestra extends StatelessWidget {
 final Widget child;
 final  String text;

  const Muestra({
    Key key,
    @required this.child,
    @required this.text,
  }) : super (key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              this.child,
              SizedBox(height: 10),
              Text(
                this.text,
                textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/