import 'package:flutter/material.dart';
import 'package:pawpoint/pages/cart/cart_widgets/cart_item.dart';
import 'package:pawpoint/size_config.dart';

Widget cartbody(state, context) {
  //return Text('Hello');
  final Orientation orientation = MediaQuery.of(context).orientation;
  return Column(children: [
    Expanded(
        child: SafeArea(
            top: false,
            bottom: false,
            child: GridView.builder(
                itemCount: state.cartProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 4.0,
                    childAspectRatio:
                        orientation == Orientation.portrait ? 3 : 1.3),
                itemBuilder: (context, i) =>
                    CartItem(item: state.cartProducts[i])))),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          
                          children: [
                            Text(
                              'Order Total ',
                              style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: w(5),
                                  color: Colors.black,
                                  // fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                ),
                            ),
                            Text('${state.ordertotalprice.toString()} EGP',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: w(5),
                                  color: Colors.black,
                                  // fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                ),
                                )
                          ]),
                
                          ]);
}
