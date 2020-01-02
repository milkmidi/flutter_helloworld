import 'package:flutter/material.dart';

class MyStateful extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyStatefulState();
}

class MyStatefulState extends State<MyStateful>{
  int counter = 0;
  String displayText = "milkmidi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(this.displayText)
            ],
          )
        )
      ),
    );
  }
}