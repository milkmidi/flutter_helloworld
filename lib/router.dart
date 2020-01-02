import 'package:flutter/material.dart';

import 'screens/HelloWorld.dart';
import 'screens/Page3.dart';
import 'screens/Page4.dart';
import 'screens/PositionPage.dart';
import 'screens/RandomWords.dart';
import 'screens/SignaturePage.dart';
import 'screens/layout_page.dart';
import 'screens/Home.dart';
import 'screens/Page1.dart';
import 'screens/Page2.dart';
import 'screens/WidgetPosition.dart';
import 'screens/WidgetValueListenableBuilder.dart';
import 'screens/ParallexPage.dart';
import 'screens/PositionedTransitionPage.dart';
import 'screens/InHeritedWidgetExample.dart';
import 'screens/PageviewHero/PageviewHero.dart';
import 'screens/GestureDetectorPage.dart';
import 'screens/RadialExpansionDemo.dart';

class RouterDataItem {
  final String name;
  final IconData iconData;
  final WidgetBuilder buildRoute;

  RouterDataItem(
      {@required this.name,
      @required this.buildRoute,
      this.iconData = Icons.home})
      : assert(name != null),
        assert(buildRoute != null);
}

final List<RouterDataItem> routerData = [
  RouterDataItem(
    name: "RadialExpansionDemo",
    buildRoute: (_) => RadialExpansionDemo()),
  RouterDataItem(
    name: "GestureDetectorPage",
    buildRoute: (_) => GestureDetectorPage()),
  RouterDataItem(
    name: "WidgetValueListenableBuilder",
    buildRoute: (_) => WidgetValueListenableBuilder()),
  RouterDataItem(
    name: "LayoutPage",
    buildRoute: (_) => LayoutPage()),
  RouterDataItem(
    name: "WidgetPosition", 
    buildRoute: (_) => WidgetPosition()),
  RouterDataItem(
    name: "HelloWorld",
    buildRoute: (_) => HelloWorld()),
  RouterDataItem(
    name: "MyHomePage",
    buildRoute: (_) => MyHomePage()),
  RouterDataItem(
    name: "Page1",
    buildRoute: (_) => Page1()),
  RouterDataItem(
    name: "Page2",
    buildRoute: (_) => Page2()),
  RouterDataItem(
    name: "Page3",
    buildRoute: (_) => Page3()),
  RouterDataItem(
    name: "Page4",
    buildRoute: (_) => Page4()),
  RouterDataItem(
    name: "RandomWords",
    buildRoute: (_) => RandomWords()),
  RouterDataItem(
    name: "PositionPage",
    buildRoute: (_) => PositionPage()),
  RouterDataItem(
    name: "SignaturePage",
    buildRoute: (_) => SignaturePage()),
  RouterDataItem(
    name: "PageviewHero",
    buildRoute: (_) => PageviewHero()),
  RouterDataItem(
    name: "ParallexPage",
    buildRoute: (_) => ParallexPage()),
  RouterDataItem(
    name: "PositionedTransitionPage",
    buildRoute: (_) => PositionedTransitionPage()),
  RouterDataItem(
    name: "InHeritedWidgetExample",
    buildRoute: (_) => InHeritedWidgetExample()),
];
