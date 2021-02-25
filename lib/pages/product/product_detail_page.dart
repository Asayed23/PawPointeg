import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/pages/product/products_page.dart';
import 'package:pawpoint/redux/actions/actions.dart';
import 'package:pawpoint/redux/actions/fav_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';

import '../../size_config.dart';

class ProductDetailPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Product item;
  ProductDetailPage({this.item});

  bool _isInCart(AppState state, int id) {
    final List<Product> cartProducts = state.cartProducts;

    return cartProducts.indexWhere((cartProduct) => cartProduct.id == id) > -1;
  }

  bool _isInFav(AppState state, int id) {
    final List<Product> favProducts = state.favProducts;
    return favProducts.indexWhere((favProduct) => favProduct.id == id) > -1;
  }

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = db_url + '${item.picture}';
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // title: Text(item.name,style: TextStyle(color:const Color(0xffe83636)))
        title: Center(
            child: Text(
          'DETIALS',
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 25,
            color: const Color(0xffe83636),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        )),
        backgroundColor: Colors.white,

        actions: <Widget>[
          StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (_, state) {
                if (state.user != null) {
                  return Container(
                      child: _fav_ico(
                          state, _isInFav, context, item, _scaffoldKey));
                } else {
                  return Text('');
                }
              })
        ],
      ),
      body: Container(
          color: Colors.white,
          // decoration: gradientBackground,
          child: Column(children: [
            Row(children: [
              Flexible(
                  child: SingleChildScrollView(
                      child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: EdgeInsets.only(top: h(5)),
                              child: Center(
                                child: Hero(
                                    tag: item,
                                    child: Image.network(pictureUrl,
                                        width:
                                            orientation == Orientation.portrait
                                                ? w(50)
                                                : 250,
                                        height:
                                            orientation == Orientation.portrait
                                                ? h(30)
                                                : 200,
                                        fit: BoxFit.cover)),
                              )))))
            ]),
            Row(children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: h(5), left: w(5), right: w(3)),
                          child: Text(
                            item.name,
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 20,
                              color: Color(0xffe83636),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ))),
                ),
              )
            ]),
            Row(children: [
              Flexible(
                  child: SingleChildScrollView(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: EdgeInsets.only(right: w(5), top: h(1)),
                              child: Text(
                                '${item.price} EGP',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: Color(0xffe83636),
                                  // fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              )))))
            ]),

            // Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 32.0),
            //     child: StoreConnector<AppState, AppState>(
            //         converter: (store) => store.state,
            //         builder: (_, state) {
            //           if (state.user != null) {
            //             return Container(
            //               child: Row(
            //                 children: [
            //                   IconButton(
            //                       icon: Icon(Icons.shopping_cart),
            //                       color: _isInCart(state, item.id)
            //                           ? Colors.cyan[700]
            //                           : Colors.white,
            //                       onPressed: () {
            //                         StoreProvider.of<AppState>(context)
            //                             .dispatch(
            //                                 toggleCartProductAction(item));
            //                         final snackbar = SnackBar(
            //                             duration: Duration(seconds: 2),
            //                             content: Text('Cart updated',
            //                                 style: TextStyle(
            //                                     color: Colors.green)));
            //                         _scaffoldKey.currentState
            //                             .showSnackBar(snackbar);
            //                       }),
            //                   // _fav_ico(state, _isInFav, context, item,
            //                   //     _scaffoldKey),
            //                 ],
            //               ),
            //             );
            //           } else {
            //             return Text('');
            //           }
            //         })),

            Row(children: [
              Flexible(
                  child: SingleChildScrollView(
                      child: Padding(
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 20,
                    color: Colors.black,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right,
                ),
                padding: EdgeInsets.only(left: w(5), top: h(1)),
              )))
            ]),

            Row(children: [
              Flexible(
                  child: SingleChildScrollView(
                      child: Padding(
                child: Text(item.description),
                padding: EdgeInsets.only(left: w(5), top: h(1), right: w(5)),
              )))
            ]),

            Padding(
                padding: EdgeInsets.only(left: w(5), top: h(1), right: w(5)),
                child: Container(
                    color: Color(0xffD8CFCF),
                    child: Row(children: [
                      Flexible(
                          child: SingleChildScrollView(
                              child: Padding(
                        child: Text(
                          'Weight',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 15,
                            color: Colors.black,
                            // fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        padding: EdgeInsets.only(left: w(0), top: h(0)),
                      ))),
                      SingleChildScrollView(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: w(55)),
                                  child: Text(
                                    '${item.weight}',
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 15,
                                      color: Color(0xffe83636),
                                      // fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.right,
                                  ))))
                    ]))),
          ])),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: w(3), bottom: h(1.5), right: w(3)),
          child: Container(
            height: h(9),
            child: Center(
                child: StoreConnector<AppState, AppState>(
                    converter: (store) => store.state,
                    builder: (_, state) {
                      if (state.user != null) {
                        return item.service == "service"
                            ? Container(
                                child: FlatButton(
                                    minWidth: w(100),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/contactus');
                                      // go to contact page
                                    },
                                    child: Text(
                                      'Contact us',
                                      // 'Add To Cart',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 20,
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    )))
                            : Container(
                                child: FlatButton(
                                    minWidth: w(100),
                                    onPressed: () {
                                      StoreProvider.of<AppState>(context)
                                          .dispatch(
                                              toggleCartProductAction(item));
                                      final snackbar = SnackBar(
                                          duration: Duration(seconds: 2),
                                          content: Text('Cart updated',
                                              style: TextStyle(
                                                  color: Colors.green)));
                                      _scaffoldKey.currentState
                                          .showSnackBar(snackbar);
                                    },
                                    child: Text(
                                      _isInCart(state, item.id)
                                          ? 'Remove from Cart'
                                          : 'Add To Cart',
                                      // 'Add To Cart',
                                      style: TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 20,
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.left,
                                    )));
                      } else {
                        return Container(
                            
                
                
                child: FlatButton(
                  minWidth: w(100),
                  onPressed: () => Navigator.pushReplacementNamed(
                                  context, '/login'),
                  child: Text(
                  
              'Sign in',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xffffffff),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            )
                ));
                        }})
            ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: const Color(0xffe83636),
                border: Border.all(width: 1.0, color: const Color(0xffd8d8d8)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(-10, -10),
                    blurRadius: 6,
                  ),
                ],
              ),
          )
      )       
                    
    );
  }
}

Widget _fav_ico(state, _isInFav, context, item, _scaffoldKey) {
  return IconButton(
      icon: Icon(
        _isInFav(state, item.id) ? Icons.favorite : Icons.favorite_border,
        size: 40,
      ),
      color: const Color(0xffe83636),
      onPressed: () {
        StoreProvider.of<AppState>(context)
            .dispatch(toggleFavProductAction(item));
        final snackbar = SnackBar(
          duration: Duration(seconds: 2),
          content: _isInFav(state, item.id)
              ? Text('Removed from favorite',
                  style: TextStyle(color: Colors.green))
              : Text('Added to Favorite',
                  style: TextStyle(color: Colors.green)),
        );
        _scaffoldKey.currentState.showSnackBar(snackbar);
      });
}
