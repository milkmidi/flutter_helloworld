import 'package:flutter/material.dart';
// Create a reusable stateless widget
class MyCard extends StatelessWidget {
  final Widget icon;
  final Widget title;

  // Constructor. {} here denote that they are optional values i.e you can use as: new MyCard()
  MyCard({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: new Card(
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[this.title, this.icon],
          ),
        ),
      ),
    );
  }
}