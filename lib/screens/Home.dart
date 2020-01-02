import 'package:flutter/material.dart';
import 'package:css_colors/css_colors.dart';
import '../widget/MyCard.dart';

class PageItem {
  final String name;
  final String path;
  const PageItem({this.name, this.path});
}

class MyHomePage extends StatefulWidget {
  final String title = "Title";


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: CSSColors.orange,
        child:SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:來個中文字1',
              ),
              Text(
                '$_counter' + '$_text',
                style: Theme.of(context).textTheme.display1,
              ),
              RaisedButton(
                child: Text("Press"),
                onPressed: onPressedHandler,
              ),
              MyCard(
                title: Text("Title"),
                icon: Icon(Icons.ac_unit),
              ),
              // MyStateful(),
              TextField(
                decoration: new InputDecoration(hintText: "打個字吧"),
                onSubmitted: _textFieldSubmited,
              )
            ],
          ),
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void onPressedHandler(){
    print('onPressedHandler');
    Navigator.of(context).pushNamed('/a');
  }

  void _textFieldSubmited(String value) {
    setState(() {
      _text = value;
    });
  }
}
