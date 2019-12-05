import 'package:flutter/material.dart';
import 'package:mr_ze_market/model/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {

  final VoidCallback buy;


  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model){

            double price = model.getProductsPrice();
            double discount = model.getDiscount();
            double ship = model.getShipPrice();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Resumo do Seu Pedido",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Subtotal"),
                    Text("R\$ ${price.toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Desconto"),
                    Text("R\$ ${discount.toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Entrega"),
                    Text("R\$ ${ship.toStringAsFixed(2)}")
                  ],
                ),
                Divider(),
                SizedBox(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total",
                      style: TextStyle(fontWeight: FontWeight.w500),),
                    Text("R\$ ${(price + ship - discount).toStringAsFixed(2)}",
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),)
                  ],
                ),
                SizedBox(height: 12.0,),


                RaisedButton(
                  child: Text("Finalizar Pedido"),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                        showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confira Suas Informações:"),
                            content: SizedBox(
                              height: 280,
                            child: Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(model.endereco!=null ? "Rua: ${model.endereco}" : "Rua Não Selecionada",
                                        style: TextStyle(fontWeight: FontWeight.w500)),
                                    leading: Icon(
                                      Icons.home,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                    ),
                                  ),
                                  Divider(),
                                  ListTile(
                                    title: Text(model.numero!=null ? "Número: ${model.numero}" : "Sem Número",
                                        style: TextStyle(fontWeight: FontWeight.w500)),
                                    leading: Icon(
                                      Icons.filter_1,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                    ),
                                  ),
                                  Divider(),
                                  ListTile(
                                    title: Text(model.complemento!=null ? "Complemento: ${model.complemento}" : "Sem Complemento",
                                        style: TextStyle(fontWeight: FontWeight.w500)),
                                    leading: Icon(
                                      Icons.spellcheck,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                    ),
                                  ),
                                  Divider(),
                                  ListTile(
                                    title: Text(model.paymethod!=null ? "Pagamento Em Dinheiro" : "Pagamento No Cartão",
                                        style: TextStyle(fontWeight: FontWeight.w500)),
                                    leading: Icon(
                                      Icons.attach_money,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ),
                            actions: <Widget>[
                              FlatButton(child: Text("Voltar",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15)),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },),
                              FlatButton(child: Text("Tudo Certo",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15)),
                                onPressed: buy
                              )
                            ],
                          );
                        });
                  }
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
