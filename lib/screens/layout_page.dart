import 'package:flutter/material.dart';
import 'package:helloworld/widget/layout_attribute_selector.dart';

class LayoutPage extends StatefulWidget {
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.start;

  layoutChangeHandler(dynamic value) {
    print('layoutChangeHandler -- ' + value.toString());
    setState(() {
      _mainAxisAlignment = value as MainAxisAlignment;
    });
  }

  layoutCrossAxisChangeHandler(dynamic value) {
    print('layoutCrossAxisChangeHandler' + value.toString());
    setState(() {
      _crossAxisAlignment = value as CrossAxisAlignment;
    });
  }

  List<Widget> _buildChildren() {
    return [
      MyDecoratedBox(child: Text('A')),
      MyDecoratedBox(child: Icon(Icons.ac_unit)),
      MyDecoratedBox(child: Text('CCC')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: LayoutAttributeSelector<MainAxisAlignment>(
                  title: 'MainAxisAlignment',
                  options: MainAxisAlignment.values,
                  onChange: layoutChangeHandler,
                ),
              ),
              Expanded(
                flex: 1,
                child: LayoutAttributeSelector<CrossAxisAlignment>(
                  title: 'CrossAxisAlignment',
                  options: CrossAxisAlignment.values,
                  onChange: layoutCrossAxisChangeHandler,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(color: Colors.yellow),
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: _mainAxisAlignment,
              children: _buildChildren(),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.cyan),
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: _mainAxisAlignment,
                crossAxisAlignment: _crossAxisAlignment,
                children: _buildChildren(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyDecoratedBox extends DecoratedBox {
  MyDecoratedBox({Widget child})
      : super(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: child,
            ),
            decoration: BoxDecoration(color: Colors.red));
}
