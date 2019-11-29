import 'package:flutter/material.dart';
import 'package:mr_ze_market/tabs/orders_tab.dart';

class OrderScreen extends StatelessWidget {

  final String orderId;

  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido Realizado"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check,
              color: Theme.of(context).primaryColor,
              size: 80.0,
            ),
            Text("Pedido realizado com sucesso!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Text("Código do pedido: $orderId", style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20,),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) =>
                        Scaffold(
                          appBar: AppBar(
                            title: Text("Meus Pedidos"),
                            centerTitle: true,
                          ),

                          body: OrdersTab(),
                        )));
              },
              child: Text(
                "Visualizar Pedidos", style: TextStyle(fontSize: 18.0),),
              textColor: Colors.white,
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
          ],
        ),
      ),
    );
  }

}

