import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_ze_market/datas/cart_product.dart';
import 'package:mr_ze_market/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';


class CartModel extends Model {

  UserModel user;
  List<CartProduct> products = [];
  String couponCode;
  int discountPercentage = 0;
  String endereco;
  String numero;
  String complemento;
  bool isLoading = false;
  String paymethod;

  CartModel(this.user){
    if(user.isLoggedIn())
      _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);


  void addCartItem(CartProduct cartProduct){
    products.add(cartProduct);

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").add(cartProduct.toMap()).then((doc){
      cartProduct.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct){
    Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").document(cartProduct.cid).delete();

    products.remove(cartProduct);

    notifyListeners();
  }

  void decProduct(CartProduct cartProduct){
    cartProduct.quantity--;
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
        .document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct){
    cartProduct.quantity++;
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
        .document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void updatePrices(){
    notifyListeners();
  }

  int getQtdCart(){
    return products.length;
  }

  double getProductsPrice(){
    double price = 0.0;
    for(CartProduct c in products){
      if(c.cardapioData != null)
        price += c.quantity * c.cardapioData.price;
    }
    return price;
  }

  double getDiscount(){
    return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice(){
    return 3.99;
  }

  String getPayMethod(){
    return paymethod;
  }

void setEndereco(String endereco){
    this.endereco = endereco;
}
  void setNumero(String numero){
    this.numero = numero;
  }
  void setComplemento(String complemento){
    this.complemento = complemento;
  }

  void setPayMethod(String paymethod){
    this.paymethod=paymethod;
  }

  String getEndereco(){
   return endereco;}

  String getNumero (){
    return numero;}
  String getComplemento(){
    return complemento;}

  Future<String> finishOrder() async {
    if(products.length == 0) return null;

    isLoading = true;
    notifyListeners();
    String endereco = getEndereco();
    String numero = getNumero();
    String complemento = getComplemento();
    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();
    String paymethod = getPayMethod();

    DocumentReference refOrder = await Firestore.instance.collection("orders").add(
        {
          "clientId": user.firebaseUser.uid,
          "products": products.map((cartProduct)=>cartProduct.toMap()).toList(),
          "shipPrice": shipPrice,
          "productsPrice": productsPrice,
          "discount": discount,
          "totalPrice": productsPrice - discount + shipPrice,
          "status": 1,
          "endereco": endereco,
          "numero": numero,
          "complemento": complemento,
          "Pagamento": paymethod

        }
    );

    await Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("orders").document(refOrder.documentID).setData(
        {
          "orderId": refOrder.documentID
        }
    );

    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("cart").getDocuments();

    for(DocumentSnapshot doc in query.documents){
      doc.reference.delete();
    }

    products.clear();

    couponCode = null;
    discountPercentage = 0;

    isLoading = false;
    notifyListeners();

    return refOrder.documentID;
  }

  void _loadCartItems() async {

    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
        .getDocuments();

    products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }

}









