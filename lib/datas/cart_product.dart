import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_ze_market/datas/cardapio_data.dart';

class CartProduct {

  String cid;

  String category;
  String pid;

  int quantity;
  String size;

  CardapioData cardapioData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    category = document.data["category"];
    pid = document.data["pid"];
    quantity = document.data["quantity"];
    size = document.data["size"];
  }

  Map<String, dynamic> toMap(){
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "product": cardapioData.toResumedMap()
    };
  }

}