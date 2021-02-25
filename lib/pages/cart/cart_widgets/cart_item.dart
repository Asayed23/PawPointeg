import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/pages/product/product_detail_page.dart';
import 'package:pawpoint/redux/actions/actions.dart';
import 'package:pawpoint/redux/state/app_state.dart';

class CartItem extends StatefulWidget {
  final Product item;
  CartItem({this.item});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool _isInCart(AppState state, int id) {
    final List<Product> cartProducts = state.cartProducts;
    return cartProducts.indexWhere((cartProduct) => cartProduct.id == id) > -1;
  }

  int _itemCount = 1;

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = db_url + '${widget.item.picture}';

    // to be able to Tap
    return Material(
      type: MaterialType.transparency,
      child: Container(
        // margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
        margin: EdgeInsets.all(0),
        // height: double.infinity,
        // width: double.infinity,
        decoration: BoxDecoration(
          border: Border(top: BorderSide( //                    <--- top side
        color: Colors.black,
        width: 1.0,
      ),
      // bottom: BorderSide( //                    <--- top side
      //   color: Colors.black,
      //   width: 1.0,
      // )
      ),
          // borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 5,
          //     blurRadius: 7,
          //     offset: Offset(0, 3), // changes position of shadow
          //   ),
          // ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
            //borderRadius: BorderRadius.circular(20),
            onTap: () {
              //   return Navigator.of(context).push(
              //     // to call product detailpage from this page and forward item
              //     MaterialPageRoute(builder: (context) {
              //   return ProductDetailPage(item: widget.item);
              // }));
            },
            child: Container(
              // margin: EdgeInsets.all(3),
              child: Row(
                children: [
                  Expanded(
                    // flex: 1,
                    child: Hero(
                      // should have the same tag
                      tag: widget.item,
                      //child: Image.network(pictureUrl),
                      child: GestureDetector(
                          onTap: () {
                            return Navigator.of(context).push(
                                // to call product detailpage from this page and forward item
                                MaterialPageRoute(builder: (context) {
                              return ProductDetailPage(item: widget.item);
                            }));
                          },
                          child: myiamge(pictureUrl)),
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
                              child: Center(
                                child: Text(
                                  "${widget.item.name}",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${widget.item.price} EGP",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        StoreConnector<AppState, AppState>(
                            converter: (store) => store.state,
                            builder: (_, state) {
                              return state.user != null
                                  ? IconButton(
                                      icon: Icon(Icons.delete),
                                      color: _isInCart(state, widget.item.id)
                                          ? Colors.red
                                          : Colors.white,
                                      onPressed: () {
                                        StoreProvider.of<AppState>(context)
                                            .dispatch(toggleCartProductAction(
                                                widget.item));

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text('Cart updated'),
                                          ),
                                        );
                                      })
                                  : Text('');
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            widget.item.quantity != 1
                                ? Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        StoreProvider.of<AppState>(context)
                                            .dispatch(updateQuantityAction(
                                                widget.item, "minus"));
                                      },
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.remove,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () => {},
                                    ),
                                  ),
                            Text(widget.item.quantity.toString()),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(updateQuantityAction(
                                            widget.item, "add"));
                                  }),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

double calculateTotalPrice(cartProducts) {
  double totalPrice = 0.0;
  cartProducts.forEach((cartProduct) {
    totalPrice += cartProduct.price;
  });
  return totalPrice;
}
