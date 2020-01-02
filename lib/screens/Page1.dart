import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  static const String name = "/page1";
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("About Page"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          padding: const EdgeInsets.only(bottom: 1.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Text("hi 95272"),
                Image.asset(
                  'assets/img/sql.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                  alignment: Alignment(-10.0,0),
                  // fit: BoxFit.none
                ),
                Image.network('https://picsum.photos/640/480')
              ],
            ),
          ),
          /* decoration: new BoxDecoration(
            image: new DecorationImage(
              image: AssetImage('assets/img/sql.png')
            )
          ), */
        ));
  }

  /* loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body);
    });
  } */
}
