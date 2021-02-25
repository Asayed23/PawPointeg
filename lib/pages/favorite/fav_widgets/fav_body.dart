import 'package:flutter/material.dart';
import 'package:pawpoint/pages/product/product_widgets/product_item.dart';
import 'package:pawpoint/pages/testpage/test_page.dart';

Widget favbody(state, context) {
  //return Text('Hello');
  final Orientation orientation = MediaQuery.of(context).orientation;
  return Column(children: [
    Expanded(
        child: SafeArea(
            top: false,
            bottom: false,
            child: GridView.builder(
              itemCount: state.favProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  childAspectRatio:
                      orientation == Orientation.portrait ? 1.0 : 1.3),
              itemBuilder: (context, i) =>
                  ProductItem(item: state.favProducts[i]),
            )))
  ]);
}
