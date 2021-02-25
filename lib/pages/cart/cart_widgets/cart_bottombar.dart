//cartbottombar
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/models/user.dart';
import 'package:pawpoint/redux/actions/order_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

Widget cartbottombar(state, context, _order) {
  return (
      //return Text('Hello');
      StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            return Container(
              height: h(9),
              margin: EdgeInsets.only(top:h(2),left: w(3), bottom: h(1.5), right: w(3)),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Color(0xffe83636),
              border: Border.all(width: 1.0, color: const Color(0xffd8d8d8)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(-10, -10),
                  blurRadius: 6,
                ),
              ],
            ),
              // height: h(14),
              child: InkWell(
                onTap: () => print('tap on close'),
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: <Widget>[
                      // Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       Text(
                      //         'Order Total ',
                      //         style: TextStyle(
                      //             color: Colors.orange, fontSize: h(2.9)),
                      //       ),
                      //       Text('${state.ordertotalprice.toString()}',
                      //           style: TextStyle(
                      //               color: Colors.white, fontSize: h(2.9)))
                      //     ]),
                          
                          
                      //      //state.ordertotalprice
                      FlatButton(
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(18.0),
                        // ),
                        // color: Colors.orange,
                        onPressed: () {
                          _order.totalprice = state.ordertotalprice;
                          StoreProvider.of<AppState>(context)
                              .dispatch(Updatecurrentorder(_order));
                          storecartindb1(state);

                          Navigator.pushNamed(context, '/shippingadd');
                        },
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 20,
                                    color: const Color(0xffffffff),
                                    
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }));
}

storecartindb1(state) {
  final List<Product> cartProducts = state.cartProducts;
  final double totalprice = state.ordertotalprice;
  final User user = state.user;
  cartProducts.forEach((productData1) {});

  cartProducts.forEach((productData) async {
    await http.put(cart_url + '${user.cartId}/',
        // body: {"products": json.encode(cartProductsIds)},
        body: {
          //"id": json.encode(cartProduct.id),
          "quantity": json.encode(productData.quantity),
          "item_price": json.encode(productData.price),
          //"CartId_id": json.encode(cartProduct.cartIdId),
          "products": json.encode(productData.id)
        }, headers: {
      "Authorization": "Bearer ${user.jwt}"
    });
  });
}
