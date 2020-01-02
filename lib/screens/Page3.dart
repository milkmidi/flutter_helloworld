import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

// https://medium.com/flutter-community/make-3d-flip-animation-in-flutter-16c006bb3798
class FlipWidget extends StatelessWidget {
  final Widget child;

  FlipWidget({this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 0.5,
            child: child,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.0),
        ),
        ClipPath(
          child: Align(
              alignment: Alignment.bottomCenter,
              heightFactor: 0.5,
              child: child),
        )
      ],
    );
  }
}

class _CounterDisplay extends StatelessWidget {
  final int count;

  _CounterDisplay({this.count});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Click $count 次'),
    );
  }
}

class _Page3State extends State<Page3> with SingleTickerProviderStateMixin{
  int _counter = 0;
   Animation<double> animation;
  AnimationController controller;

  Offset _offset = Offset.zero; // changed

  void _increment() {
    setState(() {
      _counter += 1;
    });
  }

  initState(){
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 90.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {
          print(animation.value);
          _offset = Offset( animation.value , 0.0) ;
        });
      });
    controller.forward();
  }

  dispose(){
    controller.dispose();
    super.dispose();

  }

  _defaultWidget(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Page3"),
          backgroundColor: Colors.green,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'increment',
          onPressed: _increment,
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(20.0),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(20.0),
            color: Colors.lightGreen[500],
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                FlipWidget(
                  child: Text('FlipWidget'),
                ),
                _CounterDisplay(
                  count: _counter,
                ),
                Text('$_offset'),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display1,
                ),
                RaisedButton(
                  child: Text('incremnt'),
                  onPressed: _increment,
                )
              ],
            ),
          ),
        ));
  }

  // https://medium.com/flutter-io/perspective-on-flutter-6f832f4d912e
  @override
  Widget build(BuildContext context) {
    return Transform(
      child: GestureDetector(
        onPanUpdate: (details) => setState(() => _offset += details.delta ),
        onDoubleTap: ()=> setState( ()=> _offset = Offset.zero),
        child: _defaultWidget(context),
      ),
      alignment: FractionalOffset.centerLeft,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // perspective
        // ..rotateX(0.01 * _offset.dy) // changed
        ..rotateY(-0.01 * _offset.dx), // changed
    );
  }
}

class Page3 extends StatefulWidget {
  static const String name = "/page3";

  @override
  State<StatefulWidget> createState() {
    return _Page3State();
  }
}
