import 'dart:math';

import 'package:flutter/material.dart';

class PositionPage extends StatefulWidget {
  _PositionPageState createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> {
  final List<Widget> titles = [
    Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: StatelessColorfulTile('1'),
    ),
    Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: StatelessColorfulTile('2'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: titles,
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sentiment_very_satisfied),
        onPressed: swapTitles,
      ),
    );
  }

  swapTitles() {
    print('swrapTitles');
    setState(() {
      titles.insert(1, titles.removeAt(0));
    });
  }
}

class StatelessColorfulTile extends StatelessWidget {
  final String label;
  StatelessColorfulTile(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 80.0,
      color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0),
      child: Text( "$label--" +  Random().nextInt(100).toString()),
    );
  }
}
