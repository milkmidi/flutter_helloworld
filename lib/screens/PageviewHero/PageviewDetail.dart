import 'package:flutter/material.dart';

class PageviewDetail extends StatefulWidget {
  final String _imageUrl;
  final String _texto;

  PageviewDetail(this._texto, this._imageUrl);

  @override
  _PageviewDetailState createState() => _PageviewDetailState();
}

class _PageviewDetailState extends State<PageviewDetail> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: widget._texto + "_background",
          child: Container(
            decoration: BoxDecoration(
                // color: Colors.white,
                color: Colors.red,
                borderRadius: BorderRadius.circular(0.0)
                // ,
                ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(this.widget._texto),
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Hero(
                  child: Image.network(widget._imageUrl, fit: BoxFit.none),
                  tag: widget._texto + "_img",
                ),
                Expanded(
                    child: Center(
                  child: Hero(
                      tag: widget._texto + "_text",
                      child: Text(widget._texto,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              decoration: TextDecoration.none))),
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
