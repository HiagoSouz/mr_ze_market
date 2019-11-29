import 'package:flutter/material.dart';
import 'package:mr_ze_market/model/cart_model.dart';


class ShipCard extends StatelessWidget {
  final _enderecoController = TextEditingController();
  final _numeroController = TextEditingController();
  final _complementoController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

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
              controller: _enderecoController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Rua"
              ),
              onFieldSubmitted: (text){
                if(text.isEmpty) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Por Favor, Digite Sua Rua",),
                        backgroundColor: Colors.red,));
                }
                else{
                  CartModel.of(context).setEndereco(text);
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _numeroController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Numero"
              ),
              onFieldSubmitted: (text){

                if(text.isEmpty){
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("Por Favor, Digite Seu Numero",),
                    backgroundColor: Colors.red,));}
                else{
                  CartModel.of(context).setNumero(text);
                }
              },   
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _complementoController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Complemento"
              ),
              onFieldSubmitted: (text){

                CartModel.of(context).setComplemento(text);
              },

            ),
          ),
        ],
      ),
    );
  }
}
