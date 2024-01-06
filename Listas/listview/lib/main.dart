import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          Expanded(child: ListView.builder
          (
            itemCount: 40,
            itemBuilder: (context, index) {
            return ContainnerCell();
          }))
        ],
      )),
    );
  }
}

class ContainnerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        color: Colors.grey,
        child: Text(
          'Celular da ListView',
          style: TextStyle(fontSize: 24),
        ));
  }
}
