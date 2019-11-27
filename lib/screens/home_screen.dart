import 'package:flutter/material.dart';
import 'package:mr_ze_market/tabs/cardapio_tab.dart';
import 'package:mr_ze_market/tabs/home_tab.dart';
import 'package:mr_ze_market/tabs/orders_tab.dart';
import 'package:mr_ze_market/tabs/places_tab.dart';
import 'package:mr_ze_market/widgets/cart_button.dart';
import 'package:mr_ze_market/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: CardapioTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Nossas Unidades"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
