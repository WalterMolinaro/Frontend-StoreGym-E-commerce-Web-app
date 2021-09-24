import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/pages/shopping_cart.dart';

class BuildRedButtonOnCart extends StatefulWidget {
  BuildRedButtonOnCart({Key? key}) : super(key: key);

  @override
  _BuildRedButtonOnCartState createState() => _BuildRedButtonOnCartState();
}

class _BuildRedButtonOnCartState extends State<BuildRedButtonOnCart> {
  int quantityProducts = 0;

  @override
  Widget build(BuildContext context) {
    if (ShoppingCart.staticListProducts.length > 0) {
      setState(() {
        quantityProducts = ShoppingCart.staticListProducts.length;
      });
      return Container(
        height: 15,
        width: 15,
        child: Center(
          child: Text(
            "$quantityProducts",
            style: TextStyle(fontSize: 12),
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(50)),
      );
    } else {
      return Container();
    }
  }
}
