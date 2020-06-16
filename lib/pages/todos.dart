import 'package:flutter/material.dart';

class TodosPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: Center(
        child: Text("HOLAAAAA ADMINISTRADOOOOOOOOOR")
      ),
    );
  }
}
