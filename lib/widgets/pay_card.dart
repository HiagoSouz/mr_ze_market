import 'package:flutter/material.dart';

import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mr_ze_market/model/cart_model.dart';

var controller = new MoneyMaskedTextController(leftSymbol: 'R\$ ',decimalSeparator: '.', thousandSeparator: ',');
class PayCard extends StatefulWidget {
  @override
  _PayCardState createState() => _PayCardState();
}

class _PayCardState extends State<PayCard> {
  List<bool> isSelected;
  @override
  void initState() {
    // TODO: implement initState
    isSelected = [
      false,true
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
      title: Text(
      "Forma De Pagamento",
      textAlign: TextAlign.start,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.grey[700]
      ),
    ),
    leading: Icon(Icons.monetization_on),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              ToggleButtons(
                children: <Widget>[
                  Icon(Icons.attach_money),
                  Icon(Icons.credit_card),
                ],
                isSelected: isSelected,
                onPressed: (index){
                  setState(() {
                    for (var i=0;i<isSelected.length;i++)
                      {

                        if (isSelected[1]==true && isSelected[0]==false)
                        {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Troco Para Quanto?"),
                                  content: Row(
                                    children: <Widget>[
                                       Expanded(
                                          child: TextField(
                                            controller: controller,
                                            keyboardType: TextInputType.number,
                                            autofocus: true,
                                            decoration:  InputDecoration(
                                                hintText: 'Digite o Valor'),
                                            onChanged: (text) {
                                              CartModel.of(context).setPayMethod(text);
                                            },
                                          ))
                                    ],
                                  ),
                                  actions: <Widget>[
                                    FlatButton(child: Text("OK"),
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },)
                                  ],
                                );
                              });
                        }
                        if (i==index)
                          isSelected[i]=true;
                        else
                          isSelected[i]=false;
                      }
                    });
                },
              ),
              Padding(padding: EdgeInsets.only(bottom: 20),)
                ]
              ),
          SizedBox(
            height: 10,
          )
            ],

          )
        );
  }
}
