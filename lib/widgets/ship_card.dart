import 'package:flutter/material.dart';
import 'package:mr_ze_market/model/cart_model.dart';


class ShipCard extends StatefulWidget {
  @override
  _ShipCardState createState() => _ShipCardState();
}

class _ShipCardState extends State<ShipCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Endereço Para Entrega",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]
          ),
        ),
        leading: Icon(Icons.location_on),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Rua"
              ),
              onChanged: (text){
                if(text.isEmpty)
                {
                   return "Por Favor, Digite Sua Rua";
                }
                else
                {
                  CartModel.of(context).setEndereco(text);
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Numero"
              ),
                      onChanged: (text){
                       if(text.isEmpty)
                   {
                           return "Por Favor, Digite Sua Rua";
                    }
                          else
                   {
                      CartModel.of(context).setNumero(text);
                   }}
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Complemento"
              ),
              onChanged: (text){
                CartModel.of(context).setComplemento(text);
              },

            ),
          ),
        ],
      ),
    );
  }
}