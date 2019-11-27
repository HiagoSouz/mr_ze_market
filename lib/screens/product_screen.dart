import 'package:flutter/material.dart';
import 'package:mr_ze_market/datas/cardapio_data.dart';
import 'package:mr_ze_market/datas/cart_product.dart';
import 'package:mr_ze_market/model/cart_model.dart';
import 'package:mr_ze_market/model/user_model.dart';
import 'cart_file.dart';
import 'login_screen.dart';

class ProductScreen extends StatefulWidget {

  final CardapioData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final CardapioData product;

  String size;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;



    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
              aspectRatio: 1.67,
              child: Image.network(product.images)
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Variação:",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: 72.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    //largura do botão
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 12.0,
                        childAspectRatio: 0.5
                    ),
                    children: product.sizes.map(
                            (s) {
                          return GestureDetector(
                            onTap: () {
                              setState(() { //confere se o botão foi pressionado
                                size = s;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4.0)),
                                  border: Border.all(
                                      color: s == size ? primaryColor : Colors
                                          .grey[500],
                                      //cor do botão quando selecionado
                                      width: 3.0
                                  )
                              ),
                              width: 350.0, //altura do botão
                              alignment: Alignment.center,
                              child: Text(s, textAlign: TextAlign.center
                              ),
                            ),
                          );
                        }
                    ).toList(),
                  ),
                ),
                SizedBox(height: 16.0,),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: size != null ?
                        (){
                      if(UserModel.of(context).isLoggedIn()){

                        CartProduct cartProduct = CartProduct();
                        cartProduct.size = size;
                        cartProduct.quantity = 1;
                        cartProduct.pid = product.id;
                        cartProduct.category = product.category;
                        cartProduct.cardapioData = product;

                        CartModel.of(context).addCartItem(cartProduct);

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>CartScreen())
                        );

                      } else {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>LoginScreen())
                        );
                      }
                    } : null,
                    child: Text(UserModel.of(context).isLoggedIn() ? "Adicionar ao Carrinho"
                        : "Entre para Comprar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Descrição: ",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                      fontSize: 16.0
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
