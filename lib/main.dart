import 'package:flutter/material.dart';
import 'package:mr_ze_market/model/cart_model.dart';
import 'package:mr_ze_market/model/user_model.dart';
import 'package:mr_ze_market/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                  title: "Mercado do Seu Zé",
                  theme: ThemeData(
                      primarySwatch: Colors.deepPurple,
                      primaryColor: Color.fromARGB(255, 89, 89, 171)
                  ),
                  debugShowCheckedModeBanner: false,
                  home: HomeScreen()
              ),
            );
          }
      ),
    );
  }
}