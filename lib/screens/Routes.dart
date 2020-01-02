import 'dart:async';

import 'package:flutter/material.dart';
import 'package:helloworld/widget/DrawerListener.dart';

import '../router.dart';

class Routes extends StatefulWidget {
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {

  double drawerDx = 0.0;

  Widget getNavDrawer(BuildContext context) {
    var headerChild = new DrawerHeader(child: new Text("Header"));
    var aboutChild = new AboutListTile(
        child: new Text("About"),
        applicationName: "Application Name",
        applicationVersion: "v1.0.0",
        applicationIcon: new Icon(Icons.adb),
        icon: new Icon(Icons.info));

    ListTile getNavItem(var icon, String s, String routeName) {
      return new ListTile(
        leading: new Icon(icon),
        title: new Text(s),
        onTap: () {
          setState(() {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(routeName);
          });
        },
      );
    }

    var myNavChildren = [
      headerChild,
      getNavItem(Icons.home, "Home", "/"),
      // getNavItem(Icons.settings, "Page1",  Page1.name),
      // getNavItem(Icons.settings, "Page2",  Page2.name),
      // getNavItem(Icons.settings, "Page3",  Page3.name),
      // getNavItem(Icons.settings, "Page4",  Page4.name),
      // getNavItem(Icons.account_box, "Camera", CameraPage.name),
      aboutChild
    ];

    return DrawerListener(
      onPositionChange: (FractionalOffset f) {
        print('${f.dx}');
        // https://stackoverflow.com/questions/45409565/flutter-setstate-or-markneedsbuild-called-when-widget-tree-was-locked
        Future.delayed(
            Duration.zero,
            () => setState(() {
                  drawerDx = 1.0 - f.dx;
                }));
      },
      child: Drawer(
        child: ListView(children: myNavChildren),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('$drawerDx');
    return Scaffold(
      appBar: AppBar(
        title: Text('List $drawerDx'),
        centerTitle: true,
      ),
      body: Transform(
        // offset: Offset(drawerDx, 0.0),
        alignment: FractionalOffset.centerLeft,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // perspective
          ..scale(1.0- (drawerDx*0.9))
          ..translate(drawerDx * -100)
          ..rotateY(0.5 * drawerDx), // chan
        child: Container(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListItemWidget(routerData[index]);
            },
            itemCount: routerData.length,
          ),
        ),
      ),
      drawer: getNavDrawer(context),
    );
  }
}


class ListItemWidget extends StatelessWidget {
  final RouterDataItem listItem;

  ListItemWidget(this.listItem);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(listItem.name),
        leading: Icon(listItem.iconData),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.pushNamed(context, listItem.name);
        });
  }
}
