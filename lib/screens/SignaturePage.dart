import 'package:flutter/material.dart';

class SignaturePage extends StatefulWidget {
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: GestureDetector(
          onPanUpdate: _panUpdateHandler,
          onPanEnd: _panEndHandler,
          child: CustomPaint(
            painter: Signature(points: _points),
            size: Size.infinite,
          ),
          onPanDown: _panDownHandler,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: () => _points.clear(),
      ),
    );
  }

  void _panUpdateHandler(DragUpdateDetails details) {
    setState(() {
      RenderBox render = context.findRenderObject();
      Offset _localPosition = render.globalToLocal(details.globalPosition);
      _points = List.from(_points)..add(_localPosition);
      // _points = _points..add(_localPosition);
    });
  }

  void _panEndHandler(DragEndDetails details) {
    // _points.add(null);
    _points.clear();
  }

  void _panDownHandler(DragDownDetails details) {
    RenderBox render = context.findRenderObject();
    Offset _localPosition = render.globalToLocal(details.globalPosition);
    // points = List.from(_points)..add(_localPosition);
    _points.add(_localPosition);
    setState(() {});
    // print(_localPosition);
    // _points = _points..add(_localPosition);
  }
}

class Signature extends CustomPainter {
  List<Offset> points;

  final Color color = Colors.red;
  final double percentChange = 0.5;

  Signature({this.points});

  Offset midPointBtw(Offset p1, Offset p2) {
    return Offset(p1.dx + (p2.dx - p1.dx) / 2, p1.dy + (p2.dy - p1.dy) / 2);
  }

  @override
  void paint(Canvas canvas, Size size) {
    /* for (var i = 0; i < points.length; i++) {
      Offset offset = points[i];
      Offset offsetNext = points[i + 1];
      if (offset != null && offsetNext != null) {
        canvas.drawLine(offset, offsetNext, p);
      }
    }  */
    print('paint' + points.length.toString() + size.toString());

    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    Path path = new Path();

    path.moveTo(100.0, 100.0);
    path.lineTo(200.0, 200.0);
    // path.cubicTo(100, 0, 200, 100, 200, 100);
    path.moveTo(100.0, 100.0);
    path.quadraticBezierTo(150, 0, 200, 100);
    // path.close();
    canvas.drawPath(path, paint);

    // canvas.drawLine(Offset(50,0), Offset(50.0,50.0), paint);

    // canvas.drawPath(path, p);

    // path.moveTo

    Offset p1 = points[0];
    Offset p2 = points[1];
    path.moveTo(p1.dx, p1.dy);
    for (var i = 1; i < points.length; i++) {
      var midPoint = midPointBtw(p1, p2);
      // path.lineTo(p2.dx, p2.dy);
      path.quadraticBezierTo(p1.dx, p1.dy, midPoint.dx, midPoint.dy);
      p1 = points[i];
      p2 = points[i + 1];
      canvas.drawPath(path, paint);
      // path.close();
      /* if (p1 != null && p2 != null) {
        path = Path()
          ..moveTo(p1.dx, p1.dy)
          ..close();
        // canvas.drawLine(p1, p2, p);
      } */
    }

    // Draw a circle that circumscribes the arrow.
    // paint.style = PaintingStyle.stroke;
    // canvas.drawCircle(Offset(centerX, centerY), r, paint);
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}
