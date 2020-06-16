import 'package:BerlopAdministrador/pages/mainTabs.dart';
import 'package:BerlopAdministrador/pages/welcome.dart';
import 'package:BerlopAdministrador/routes.dart';
import 'package:BerlopAdministrador/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatefulWidget{
  @override 
  State<StatefulWidget> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp>{
  Widget _rootPage = WelcomePage();

  Future<Widget> getRootPage() async =>
    await FirebaseAuth.instance.currentUser() == null
      ? WelcomePage()
      : MainTabsPage();

  @override
  initState() {
    super.initState();
    getRootPage().then(( Widget page) {
      setState(() {
        _rootPage = page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Todos App',
      home: _rootPage,
      routes: buildAppRoutes(),
      theme: buildAppTheme(),
    );
  }
}
