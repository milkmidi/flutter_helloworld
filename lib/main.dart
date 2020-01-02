import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import 'privodes/Privodes.dart';
import 'router.dart';
import 'screens/Routes.dart';

void main() {
  var counter = Counter();
  var switcher = Switcher();
  var providers = Providers();
  providers
    ..provide(Provider<Switcher>.value(switcher))
    ..provide(Provider<Counter>.value(counter));
  runApp(ProviderNode(
    providers: providers,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.green,
          backgroundColor: Colors.red),
      home: Routes(),
      routes: _buildRoutes(),
      debugShowCheckedModeBanner: false,
    );
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return Map<String, WidgetBuilder>.fromIterable(
      routerData,
      key: (dynamic demo) => '${demo.name}',
      value: (dynamic demo) => demo.buildRoute,
    );
  }
}
