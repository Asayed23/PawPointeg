import 'package:flutter/material.dart';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/pages/product/product_detail_page.dart';
import 'package:pawpoint/redux/state/app_state.dart';

class OrderItem extends StatefulWidget {
  final Map item;
  OrderItem({this.item});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isInCart(AppState state, int id) {
    final List<Product> cartProducts = state.cartProducts;
    return cartProducts.indexWhere((cartProduct) => cartProduct.id == id) > -1;
  }

  int _itemCount = 1;

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = db_url + '${widget.item['picture']}';
    // to be able to Tap
    return Wrap(children: [
      Material(
        type: MaterialType.transparency,
        child: Container(
          // margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
          // height: double.infinity,
          // width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.white70.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Hero(
                      // should have the same tag
                      tag: widget.item,
                      //child: Image.network(pictureUrl),
                      child: myiamge(pictureUrl),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${widget.item['name']}",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${widget.item['price']} EGP",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.red),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(child: Text(widget.item['quantity'].toString())),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

// to show circular progress bar during loading
Widget myiamge(pictureUrl) {
  return (Image.network(
    pictureUrl,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes
              : null,
        ),
      );
    },
  ));
}
