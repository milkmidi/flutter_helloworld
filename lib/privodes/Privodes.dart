import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  int value = 0;
  String hahh = '';
  void increment() {
    value += 1;
    hahh = 'haha $value';
    notifyListeners();
  }
}
///Switcher
class Switcher extends ChangeNotifier {
  bool checked = false;
  void check() {
    checked = !checked;
    notifyListeners();
  }
}