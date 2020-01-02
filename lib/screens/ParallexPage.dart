import 'package:flutter/material.dart';

// https://zhuanlan.zhihu.com/p/34198390
class ParallexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ParallexPageState();
}

class _ParallexPageState extends State<ParallexPage> {
  final PageController _pageController = PageController();
  double _currentPage = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Page Demo'),
        ),
        body: LayoutBuilder(
            builder: (context, constraints) => NotificationListener(
                  onNotification: (ScrollNotification note) {
                    setState(() {
                      _currentPage = _pageController.page;
                    });
                  },
                  child: PageView.custom(
                    physics: const PageScrollPhysics(
                        parent: const BouncingScrollPhysics()),
                    controller: _pageController,
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, index) => _ParallexItem(
                            '$index',
                            parallaxOffset: constraints.maxWidth / 2.0 * (index - _currentPage),
                          ),
                      childCount: 10,
                    ),
                  ),
                )),
      );
  }
}

class _ParallexItem extends StatelessWidget {
  _ParallexItem(this.data, {Key key, this.parallaxOffset = 0.0})
      : super(key: key);

  final String data;
  final double parallaxOffset;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                data,
                style: const TextStyle(fontSize: 60.0),
              ),
              SizedBox(height: 40.0),
              Transform(
                transform: Matrix4.translationValues(parallaxOffset, 0.0, 0.0),
                child: Column(
                  children: <Widget>[
                    Image.network('https://fakeimg.pl/320x320/'),
                    const Text('Yet another line of text'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
