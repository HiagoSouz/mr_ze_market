import 'package:flutter/material.dart';
import 'package:mr_ze_market/model/cart_model.dart';
import 'package:mr_ze_market/screens/cart_file.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:badges/badges.dart';
import 'package:mr_ze_market/model/cart_model.dart';

class CartButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

        return ScopedModelDescendant<CartModel>(
            builder: (context, child, model)=> FloatingActionButton(
              child: Badge(
                badgeContent:
                Text ("${model.products.length}"),
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
            ));
            }
  }

