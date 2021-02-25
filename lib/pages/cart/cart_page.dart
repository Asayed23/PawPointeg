import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/models/order.dart';
import 'package:pawpoint/pages/cart/cart_widgets/cart_body.dart';
import 'package:pawpoint/pages/cart/cart_widgets/cart_bottombar.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        Order _order;
        // Order _order = Order();
        _order = state.currentorder;

        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(4.0),
              child: Icon(
                Icons.shopping_cart,
                color: const Color(0xffe83636),
                size: h(4),

              ),
            ),
            centerTitle: true,
            title: Text(
              'Shopping Cart',
              style: TextStyle(color: const Color(0xffe83636)),
            ),
          ),
          body: state.cartProducts.length > 0
              ? cartbody(state, context)
              : Container(
                  child: Center(child: Text('Your Cart is Empty')),
                ),
          bottomNavigationBar: state.cartProducts.length > 0
              ? cartbottombar(state, context, _order)
              : Text(''),
        );
      },
    ));
  }
}
