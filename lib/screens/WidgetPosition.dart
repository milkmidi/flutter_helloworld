import 'package:flutter/material.dart';

// https://www.youtube.com/watch?v=EgtPleVwxBQ&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=27
class WidgetPosition extends StatefulWidget {
  @override
  _WidgetPositionState createState() => _WidgetPositionState();
}

class _WidgetPositionState extends State<WidgetPosition> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    print(deviceSize);
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Container(
          padding: EdgeInsets.all(40.0),
          decoration: BoxDecoration(color: Colors.red),
          child: SizedBox(
            width: deviceSize.width / 2,
            height: deviceSize.height * 0.5,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  'assets/img/me.jpg',
                  fit: BoxFit.fitHeight,
                ),
                Positioned.fill(
                  left: 40.0,
                  top: 20.0,
                  child: Image.asset('assets/img/sql.png', fit: BoxFit.cover,),
                )
              ],
            ),
          )),
    );
  }
}
