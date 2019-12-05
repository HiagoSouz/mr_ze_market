import 'package:flutter/material.dart';
import 'package:mr_ze_market/model/cart_model.dart';
import 'package:mr_ze_market/model/user_model.dart';
import 'package:mr_ze_market/screens/order_screen.dart';
import 'package:mr_ze_market/tile/cart_tile.dart';
import 'package:mr_ze_market/widgets/cart_price.dart';
import 'package:mr_ze_market/widgets/discount_card.dart';
import 'package:mr_ze_market/widgets/pay_card.dart';
import 'package:mr_ze_market/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';
int qtd;
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model){
                int p = model.products.length;
                return Text(
                  "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
          builder: (context, child, model){
            qtd = model.products.length;
            if(model.isLoading && UserModel.of(context).isLoggedIn()){
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (!UserModel.of(context).isLoggedIn()){
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.remove_shopping_cart,
                      size: 80.0, color: Theme.of(context).primaryColor,),
                    SizedBox(height: 16.0,),
                    Text("Faça o login para adicionar produtos!",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0,),
                    RaisedButton(
                      child: Text("Entrar", style: TextStyle(fontSize: 18.0),),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>LoginScreen())
                        );
                      },
                    )
                  ],
                ),
              );
            } else if (model.products == null || model.products.length == 0){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Nenhum Produto No Carrinho!",
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,),
                  Icon(Icons.sentiment_dissatisfied,
                    color: Theme.of(context).primaryColor,
                    size: 80.0,
                  ),
                ],
              );
            } else {
              return ListView(
                children: <Widget>[
                  Column(
                    children: model.products.map(
                            (product){
                          return CartTile(product);
                        }
                    ).toList(),
                  ),
                  DiscountCard(),
                  ShipCard(),
                  PayCard(),
                  CartPrice(() async {
                    String orderId = await model.finishOrder();
                      if(orderId != null)
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context)=>OrderScreen(orderId))
                      );
                  }
                    ),
                ],
              );
            }
          }
      ),
    );
  }
}










