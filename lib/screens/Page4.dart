import 'package:flutter/material.dart';
// 原文：https://blog.csdn.net/hekaiyou/article/details/53088815

class Product {
  const Product({this.name});
  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  ShoppingListItem({this.product, this.inCart, this.onCartChanged})
      : super(key: new ObjectKey(product));

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;
    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]),
      ),
      title: new Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class Page4 extends StatefulWidget {
  static final String name = '/page4';
  final List<Product> products = <Product>[
    new Product(name: '雞蛋'),
    new Product(name: '麵粉'),
    new Product(name: '巧克力脆片'),
  ];
  @override
  _ShoppingListState createState() => new _ShoppingListState();
}

class _ShoppingListState extends State<Page4> {
  Set<Product> _shoppingCart = new Set<Product>();
  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('購物清單'),
      ),
      body: new ListView(
        children: widget.products.map((Product product) {
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}
