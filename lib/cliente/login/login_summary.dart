import 'package:flutter/material.dart';

class LoginSummary extends StatelessWidget {
  final bool horizontal;

  LoginSummary({this.horizontal});

  @override
  Widget build(BuildContext context) {
    final imageThumbnail = Container(
    margin: EdgeInsets.symmetric(
      vertical: 16.0,
    ),
    alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
    child: Container(
      height: 90.0,
      width: 90.0,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(50.0),
        image: DecorationImage(
          image: AssetImage("assets/images/logoBerlopB.jpeg"),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          new BoxShadow(
            color: Color(0xffA4A4A4),
            offset: Offset(1.0, 5.0),
            blurRadius: 3.0,
          ),
        ],
      ),
    ),
  );
  final userCardContent = Container(
    margin: EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
    constraints: BoxConstraints.expand(),
    child: Column(
      crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: <Widget>[
        Container(height: 4.0),
        Text(
          "Administración de clientes",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
  final userCard = Container(
    child: userCardContent,
    height: horizontal ? 124.0 : 154.0, 
    margin: horizontal
      ? EdgeInsets.only(left: 46.0)
      : EdgeInsets.only(top: 72.0),
    decoration: BoxDecoration(
      color: Colors.blue[900],
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0xffA4A4A4),
          blurRadius: 5.0,
          offset: Offset(0.0, 5.0),
        )
      ],
    ),
  );
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: Stack(
        children: <Widget>[
          userCard,
          imageThumbnail
        ],
      ),
    );
  }
}