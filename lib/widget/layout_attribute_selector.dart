import 'package:flutter/material.dart';

class LayoutAttributeSelector<T> extends StatefulWidget {
  final String title;
  final List<T> options;
  final ValueChanged<T> onChange;

  LayoutAttributeSelector({
    @required this.title,
    @required this.options,
    @required this.onChange
  });
  _LayoutAttributeSelectorState createState() => _LayoutAttributeSelectorState();
}

class _LayoutAttributeSelectorState extends State<LayoutAttributeSelector> {
  int valueIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: <Widget>[
           Divider(color: Colors.black54),
           Text(widget.title),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               IconButton(
                 padding: EdgeInsets.all(4.0),
                 icon: Icon(Icons.arrow_back),
                 onPressed: prev,
               ),
               Text(
                 widget.options[valueIndex].index.toString(),
                //  widget.options[valueIndex].toString(),
                 maxLines: 2,
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   fontWeight: FontWeight.w700,
                   color: Colors.black87,
                   fontSize: 8.0
                 )
               ),
               IconButton(
                 padding: EdgeInsets.all(4.0),
                 icon: Icon(Icons.arrow_forward), 
                 onPressed: next,
               )
             ],
           )
         ],
       ),
    );
  }

  void next(){
    print(widget.options.length);
    valueIndex = (valueIndex + 1) % widget.options.length;
    update();
  }
  void prev(){
    valueIndex = (valueIndex - 1 + widget.options.length) % widget.options.length;
    update();
  }
  void update(){
    widget.onChange(widget.options[valueIndex]);
    setState(() {});
  }
}