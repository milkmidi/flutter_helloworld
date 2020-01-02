import 'package:flutter/material.dart';
import 'package:helloworld/privodes/Privodes.dart';
import 'package:provide/provide.dart';

class HelloWorld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print(size);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi'),
      ),
      body: Provide<Counter>(builder: (context, child, counter) {
        return Container(
          child: Column(
            children: <Widget>[
              Text(
                'HelloWorld, ${counter.value}',
              ),
              Placeholder()
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Provide.value<Counter>(context).increment();
        },
      ),
    );
  }
}
