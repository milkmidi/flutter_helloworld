import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './MyScopedModel.dart';

class ScopedModelExample extends StatefulWidget {
  @override
  _ScopedModelExampleState createState() => _ScopedModelExampleState();
}

class _ScopedModelExampleState extends State<ScopedModelExample> {

  final MyScopedModel _model = MyScopedModel();
  @override
  void initState() {
    super.initState();
    _model.fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MyScopedModel>(
      model: _model,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Scoped Model')
        ),
        body: ScopedModelDescendant<MyScopedModel>(
          builder: (BuildContext context, Widget child, MyScopedModel model) {
            if (model.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Container(
              child: Text(model.postData.body)
            );
          }
        ),
      ),
    );
  }
}

