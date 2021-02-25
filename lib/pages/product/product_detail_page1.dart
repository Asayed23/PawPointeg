import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/pages/product/products_page.dart';
import 'package:pawpoint/redux/actions/actions.dart';
import 'package:pawpoint/redux/actions/fav_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';

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
        appBar: AppBar(title: Text(item.name)),
        body: Container(
            decoration: gradientBackground,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Hero(
                    tag: item,
                    child: Image.network(pictureUrl,
                        width: orientation == Orientation.portrait ? 600 : 250,
                        height: orientation == Orientation.portrait ? 400 : 200,
                        fit: BoxFit.cover)),
              ),
              Text(item.name, style: Theme.of(context).textTheme.title),
              Text('\$${item.price}', style: Theme.of(context).textTheme.body1),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: StoreConnector<AppState, AppState>(
                      converter: (store) => store.state,
                      builder: (_, state) {
                        if (state.user != null) {
                          return Container(
                            child: Row(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.shopping_cart),
                                    color: _isInCart(state, item.id)
                                        ? Colors.cyan[700]
                                        : Colors.white,
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
                                    }),
                                _fav_ico(state, _isInFav, context, item,
                                    _scaffoldKey),
                              ],
                            ),
                          );
                        } else {
                          return Text('');
                        }
                      })),
              Flexible(
                  child: SingleChildScrollView(
                      child: Padding(
                          child: Text(item.description),
                          padding: EdgeInsets.only(
                              left: 32.0, right: 32.0, bottom: 32.0))))
            ])));
  }
}

Widget _fav_ico(state, _isInFav, context, item, _scaffoldKey) {
  return IconButton(
      icon: Icon(
        Icons.favorite_border,
        size: 40,
      ),
      color: _isInFav(state, item.id) ? Colors.white : Color(0xffe83636),
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
