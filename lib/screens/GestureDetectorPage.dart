import 'package:flutter/material.dart';

class GestureDetectorPage extends StatefulWidget {
  GestureDetectorPage({Key key}) : super(key: key);

  _GestureDetectorPageState createState() => _GestureDetectorPageState();
}

class _GestureDetectorPageState extends State<GestureDetectorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GestureDetectorPage'),
      ),
      body: GestureDetector(
        onTap: () {
          print('onTap');
        },
        onHorizontalDragStart: (DragStartDetails detail) {
          print('onHorizontalDragStart, $detail');
        },
        onHorizontalDragUpdate: (DragUpdateDetails update) {
          // print('onHorizontalDragUpdate, $detail');
          RenderBox getBox = context.findRenderObject();
          var local = getBox.globalToLocal(update.globalPosition);
          print(local.dx.toString() + "|" + local.dy.toString());
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.lightBlueAccent),
          width: double.infinity,
          height: double.infinity,
          child: Center(child: Text('hi')),
        ),
      ),
    );
  }
}
