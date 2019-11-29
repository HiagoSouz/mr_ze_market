import 'package:flutter/material.dart';
import 'package:mr_ze_market/model/cart_model.dart';
import 'package:mr_ze_market/screens/cart_file.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:badges/badges.dart';


class CartButton extends StatelessWidget {
  int totalProducts;
  @override
  Widget build(BuildContext context) {

    /*Scaffold(
      body: Center(
        child: ScopedModelDescendant<CartModel>(
            builder: (context, child, model){
              int qtd = model.products.length;
              //setState(()
              {
                totalProducts = qtd;
              });
            }
        ),
      ),
    );
    */

    return FloatingActionButton(
      child: Badge(
        badgeContent: Text("${totalProducts}"),
        child: Icon(Icons.shopping_cart),
      ),
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CartScreen())
        );
      },
      backgroundColor: Theme
          .of(context)
          .primaryColor,
    );
  }
}

