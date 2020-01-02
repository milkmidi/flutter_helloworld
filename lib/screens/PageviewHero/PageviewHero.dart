import 'package:flutter/material.dart';

import 'PageviewDetail.dart';

double _getFraction(int i, double selected, double tot) {
  double f = 0;
  f = i - selected;
  f /= tot / 2;
  while (f < -1) f += 2;
  while (f > 1) f -= 2;
  return f;
}

// https://www.youtube.com/watch?v=DSrAA7DdAyM
class PageviewHero extends StatefulWidget {
  @override
  _PageviewHeroState createState() => _PageviewHeroState();
}

class _PageviewHeroState extends State<PageviewHero> {
  PageController pageController;
  double pageOffset = 0.0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.6)
      ..addListener(() {
        setState(() => pageOffset = pageController.page);
        // print(pageOffset);
      });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: Container(
        decoration: BoxDecoration(color: Color(0xFFF1F7FB)),
        child: Center(
          /* child: PageView.builder(
            controller: pageController,
            itemCount: 10,
            itemBuilder: (BuildContext context, int position){
              return CardWidget('Basketball day!',
                  'https://picsum.photos/id/1/640/480', pageOffset, position);
            },
            onPageChanged: (int currentPage){
              print('currentPage:$currentPage');
            },
          ) */
          child: PageView(
            // pageSnapping: false,
            controller: pageController,
            children: <Widget>[
              CardWidget('Basketball day!',
                  'https://picsum.photos/id/1/640/480', pageOffset, 0),
              CardWidget('Let\'s play Soccer',
                  'https://picsum.photos/id/2/640/480', pageOffset, 1),
              CardWidget('American Futball',
                  'https://picsum.photos/id/3/640/480', pageOffset, 2),
            ],
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  String _imageUrl;
  String _texto;
  double offset;
  int index;

  CardWidget(this._texto, this._imageUrl, this.offset, this.index);

  @override
  Widget build(BuildContext context) {
    Widget page = PageviewDetail(_texto, _imageUrl);
    return GestureDetector(
      child: _crearContenedor(context),
      onTap: () {
        Navigator.push(
            context,
            // buildMaterialPageRoute(page));
            buildCustomPageRoute(page));
      },
    );
  }

  Route buildMaterialPageRoute(Widget page) {
    return MaterialPageRoute(builder: (context) => page);
    // builder: (context) => PageviewDetail(_texto, _imageUrl));
  }

  Route buildCustomPageRoute(Widget page) {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            page,
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            // child:child,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(0.0, 1.0),
              ).animate(secondaryAnimation),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 2000));
  }

  Widget _crearContenedor(BuildContext context) {
    double fraction = _getFraction(index, offset, 4);
    return Center(
      child: SizedBox(
        width: 330,
        height: 325,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color.fromARGB(30, 0, 0, 0),
                    offset: Offset(0.0, 10.0),
                    spreadRadius: 0,
                    blurRadius: 10)
              ]),
          child: Stack(
            children: <Widget>[
              Hero(
                tag: _texto + "_background",
                child: Container(
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              Card(
                  elevation: 0,
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      _crearImagenFondo(fraction),
                      Column(
                        children: <Widget>[
                          Container(margin: EdgeInsets.only(top: 10)),
                          _crearHeader(),
                          Expanded(child: Container()),
                          _mensaje(fraction)
                        ],
                      )
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearHeader() {
    //  double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08)); //<--caluclate Gaussian function
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Column(
            children: <Widget>[
              Text('16',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              Text('Oct', style: TextStyle(color: Colors.white)),
              Text('2019', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        Container(
          child: Icon(Icons.favorite, color: Colors.white, size: 50),
          margin: EdgeInsets.only(right: 10),
        )
      ],
    );
  }

  Widget _crearImagenFondo(double fraction) {
    return Hero(
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/img/loading.gif',
        image: _imageUrl,
        fit: BoxFit.none,
        alignment: Alignment(-1 * fraction, 0),
      ),

      // child: Image.network(
      //   _imageUrl,
      //   fit: BoxFit.none,
      //   alignment: Alignment(-1 * fraction, 0),
      // ),
      tag: _texto + "_img",
    );
  }

  Widget _mensaje(double fraction) {
    return Transform.translate(
      offset: Offset(208 * fraction, 0),
      child: Container(
        alignment: Alignment.bottomLeft,
        margin: EdgeInsets.only(bottom: 20, left: 20),
        child: Hero(
          tag: _texto + "_text",
          child: Text(
            _texto,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
