import 'package:flutter/material.dart';

class PositionedTransitionPage extends StatefulWidget {
  PositionedTransitionPage({Key key}) : super(key: key);

  _PositionedTransitionPageState createState() =>
      _PositionedTransitionPageState();
}

class _PositionedTransitionPageState extends State<PositionedTransitionPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation; // Animation on which TweenSequence runs

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );

    RelativeRectTween rectTween = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0.0, 0.0, 240.0, 240.0),
      end: const RelativeRect.fromLTRB(240.0, 240, 0.0, 0.0),
    );

    ElasticInOutCurve elasticInOut = const ElasticInOutCurve();

    animation = rectTween
        .animate(CurvedAnimation(parent: _controller, curve: elasticInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    // Call setState here to update layerAnimation if that's necessary
    setState(() {
      _frontLayerVisible ? _controller.reverse() : _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _toggleBackdropLayerVisibility,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            PositionedTransition(
              rect: animation,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(width: 5.0, color: Colors.green)
                  ),
                child: Image.asset('assets/img/sql.png'),
              ),
              // child: 
            ),
          ],
        ),
      ),
    );
  }
}

