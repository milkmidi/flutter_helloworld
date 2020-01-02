// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'package:flutter/material.dart';

class WidgetValueListenableBuilder extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WidgetValueListenableBuilder'),
      ),
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SimpleValue(),
          SizedBox(height: 25),
          ComplexValue(),
          SizedBox(height: 25),
          MoreComplexValue(),
          SizedBox(height: 25),
          AnimationValue(),
        ],
      ))),
    );
  }
}

/// Using ValueNotifier directly to wrap a simple value
class SimpleValue extends StatefulWidget {
  @override
  createState() => _SimpleValueState();
}

class _SimpleValueState extends State<SimpleValue> {
  final _simpleValue = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ValueListenableBuilder(
            valueListenable: _simpleValue,
            builder: (context, value, _) {
              return Text('Value: $value');
            }),
        FlatButton(
          child: Text('Increment'),
          onPressed: () => _simpleValue.value+=10,
        )
      ],
    );
  }
}

/// Extending ValueNotifier for more complex behavior
class ComplexValueNotifier extends ValueNotifier<String> {
  ComplexValueNotifier(String value) : super(value);

  void addDot() => value = value + '.';
}

class ComplexValue extends StatefulWidget {
  @override
  createState() => _ComplexValueState();
}

class _ComplexValueState extends State<ComplexValue> {
  final _complexValue = ComplexValueNotifier('I\'ve been clicked');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ValueListenableBuilder(
            valueListenable: _complexValue,
            builder: (context, value, _) {
              return Text(value);
            }),
        FlatButton(
          child: Text('Click me'),
          onPressed: () => _complexValue.addDot(),
        )
      ],
    );
  }
}

/// If the value itself doesn't directly change, call notifyListeners()
class _Counter {
  _Counter(this.count);
  int count;
  void increment() => count++;
}

class MoreComplexValueNotifier extends ValueNotifier<_Counter> {
  MoreComplexValueNotifier(_Counter value) : super(value);

  void addTwo() {
    value.increment();
    value.increment();
    notifyListeners();
  }
}

class MoreComplexValue extends StatefulWidget {
  @override
  createState() => _MoreComplexValueState();
}

class _MoreComplexValueState extends State<MoreComplexValue> {
  final _moreComplexValue = MoreComplexValueNotifier(_Counter(0));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ValueListenableBuilder(
            valueListenable: _moreComplexValue,
            builder: (context, value, _) {
              return Text(value.count.toString());
            }),
        FlatButton(
          child: Text('Click me'),
          onPressed: () => _moreComplexValue.addTwo(),
        )
      ],
    );
  }
}

/// There are many notifiers in Flutter; animation is one of them
class AnimationValue extends StatefulWidget {
  @override
  createState() => _AnimationValueState();
}

class _AnimationValueState extends State<AnimationValue>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      child: Container(width: 100.0, height: 100.0, color: Colors.green),
      builder: (context, value, child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * math.pi,
          child: child,
        );
      },
    );
  }
}
