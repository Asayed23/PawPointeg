import 'dart:convert';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/cart.dart';
import 'package:pawpoint/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:pawpoint/models/user.dart';
import 'package:pawpoint/redux/actions/fav_action.dart';
import 'package:pawpoint/redux/actions/inloading_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Getordertotalprice {
  final double _ordertotalprice;

  double get ordertotalprice => this._ordertotalprice;

  Getordertotalprice(this._ordertotalprice);
}

/* User Actions */
ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString('user');
  final user =
      storedUser != null ? User.fromJson(json.decode(storedUser)) : null;
  store.dispatch(GetUserAction(user));
  store.state.inloading.user = false;
  store.dispatch(UpdateInloading(store.state.inloading));
};

ThunkAction<AppState> logoutUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');
  User user;
  store.dispatch(LogoutUserAction(user));
};

class GetUserAction {
  final User _user;

  User get user => this._user;

  GetUserAction(this._user);
}

class LogoutUserAction {
  final User _user;

  User get user => this._user;

  LogoutUserAction(this._user);
}

class UpdateUserAction {
  final User _user;

  User get user => this._user;

  UpdateUserAction(this._user);
}

/* Products Actions */
ThunkAction<AppState> getProductsAction = (Store<AppState> store) async {
  http.Response response = await http.get(product_url);

  final List<dynamic> responseData = json.decode(response.body);

  List<Product> products = [];
  // final _prodleng = products.length;

  // bool _hasmore = store.state.products.length + 200 <= responseData.length;

  // for (var i = _prodleng; i < _prodleng + 200 && i < responseData.length; i++) {

  //   final Product product = Product.fromJson(responseData[i]);
  //   product.hasmore = _hasmore;
  //   products.add(product);
  // }

  responseData.forEach((productData) {
    final Product product = Product.fromJson(productData);
    products.add(product);
  });
  store.dispatch(GetProductsAction(products));
  store.state.inloading.allproduct = false;
  store.dispatch(UpdateInloading(store.state.inloading));
};

class GetProductsAction {
  final List<Product> _products;

  List<Product> get products => this._products;

  GetProductsAction(this._products);
}

/* Cart Products Actions */
ThunkAction<AppState> toggleCartProductAction(Product cartProduct) {
  return (Store<AppState> store) async {
    final List<Product> cartProducts = store.state.cartProducts;
    final User user = store.state.user;
    final int index =
        cartProducts.indexWhere((product) => product.id == cartProduct.id);
    final int pos = cartProducts.length;
    // ? cartProducts.length + 1
    // : cartProducts.length;

    bool isInCart = index > -1 == true;
    List<Product> updatedCartProducts = List.from(cartProducts);
    if (isInCart == false) {
      updatedCartProducts.add(cartProduct);
      updatedCartProducts[pos].quantity = 1;
      updatedCartProducts[pos].itemPrice = updatedCartProducts[pos].price;
      // put in database
      //final List<int> cartProductsIds =
      updatedCartProducts.map((product) => product.id).toList();

      togglestorecartindb(cartProduct, "add", '$cart_url${user.cartId}/');
      print('############ add to database');

      // await http.put(cart_url + '${user.cartId}/',
      //     // body: {"products": json.encode(cartProductsIds)},
      //     body: {
      //       //"id": json.encode(cartProduct.id),
      //       "quantity": json.encode(updatedCartProducts[pos].quantity),
      //       "item_price": json.encode(updatedCartProducts[pos].itemPrice),
      //       //"CartId_id": json.encode(cartProduct.cartIdId),
      //       "products": json.encode(updatedCartProducts[pos].productidId)
      //     }, headers: {
      //   "Authorization": "Bearer ${user.jwt}"
      // });
    } else {
      updatedCartProducts.removeAt(index);
      togglestorecartindb(cartProduct, "remove", '$cart_url${user.cartId}/');
      print('############ Remove from database');
      // updatedCartProducts[index].itemPrice = updatedCartProducts[index].price;

      //index = index + 1;
    }

    double totalPrice = 0;
    updatedCartProducts.forEach((cartProduct) {
      totalPrice = totalPrice + (cartProduct.price * cartProduct.quantity);
    });
    store.dispatch(Getordertotalprice(totalPrice));

    store.dispatch(ToggleCartProductAction(updatedCartProducts));
  };
}

togglestorecartindb(productData, statusof, url1) async {
  await http.put(
    url1,
    // body: {"products": json.encode(cartProductsIds)},
    body: {
      //"id": json.encode(cartProduct.id),
      "quantity": json.encode(productData.quantity),
      "item_price": json.encode(productData.price),
      //"CartId_id": json.encode(cartProduct.cartIdId),
      "products": json.encode(productData.id),
      "add_remove": statusof,
    },
    //headers: {"Authorization": "Bearer ${user.jwt}"}
  );
}

storecartindb() {
  return (Store<AppState> store) {
    final List<Product> cartProducts = store.state.cartProducts;
    //final double totalprice = store.state.ordertotalprice;
    final User user = store.state.user;

    cartProducts.forEach((productData) async {
      await http.put(cart_url + '${user.cartId}/',
          // body: {"products": json.encode(cartProductsIds)},
          body: {
            //"id": json.encode(cartProduct.id),
            "products": json.encode(productData.quantity),
            "item_price": json.encode(productData.itemPrice),
            //"CartId_id": json.encode(cartProduct.cartIdId),
            //"products": json.encode(productData.id)
          }, headers: {
        "Authorization": "Bearer ${user.jwt}"
      });
    });
  };
}

ThunkAction<AppState> getCartProductsAction = (Store<AppState> store) async {
  //User user = store.state.user;
  final prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString('user');
  print(store.state.cartProducts);

  if (storedUser == null) {
    store.dispatch(GetCartProductsAction([]));
    return;
  }

  final User user = User.fromJson(json.decode(storedUser));
  print('####################get cart product');
  print(cart_url + '${user.cartId}/');
  http.Response response = await http.get(cart_url + '${user.cartId}/',
      headers: {'Authorization': 'Bearer ${user.jwt}'});
  final responseData = json.decode(response.body)['products'];
  final cartData = json.decode(response.body)['cartitems'];

  double totalPrice = 0;
  List<Product> cartProducts = [];
  responseData.asMap().forEach((index, productData) {
    final Product product = Product.fromJson(productData[0]);
    // get quantity from ['cartitems'] using productid_id
    product.quantity = cartData[index]['quantity'];
    totalPrice = totalPrice +
        (cartData[index]['item_price'] * cartData[index]['quantity']);
    cartProducts.add(product);
  });
  store.dispatch(GetCartProductsAction(cartProducts));
  store.dispatch(Getordertotalprice(totalPrice));
};

///////////////////////////////// Update Quantity //////////////////////////
///

ThunkAction<AppState> updateQuantityAction(Product cartProduct, String sign) {
  return (Store<AppState> store) async {
    final List<Product> cartProducts = store.state.cartProducts;

    // final User user = store.state.user;

    final _index = cartProducts.indexWhere((item) => item.id == cartProduct.id);

    if (sign == "add") {
      cartProducts[_index].quantity = cartProducts[_index].quantity + 1;
    } else {
      cartProducts[_index].quantity = cartProducts[_index].quantity - 1;
    }

    double totalPrice = 0;
    cartProducts.forEach((cartProduct) {
      totalPrice = totalPrice + (cartProduct.price * cartProduct.quantity);
    });
    store.dispatch(Getordertotalprice(totalPrice));
    store.dispatch(UpdateQuantityAction(cartProducts));
  };
}

class UpdateQuantityAction {
  final List<Product> _cartProducts;

  List<Product> get cartProducts => this._cartProducts;

  UpdateQuantityAction(this._cartProducts);
}

///////////////// end of Quantity /////////////////

///cart
////
///
///

ThunkAction<AppState> getcartItemsAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString('user');
  if (storedUser == null) {
    return;
  }
  final User user = User.fromJson(json.decode(storedUser));
  if (user.cartId == null) {
    return;
  }
  http.Response response = await http.get(cart_url + '/${user.cartId}/',
      headers: {'Authorization': 'Bearer ${user.jwt}'});
  final responseData = json.decode(response.body)['cartitems'];

  List<Cart> cartItems = [];
  responseData.forEach((cartdata) {
    final Cart product1 = Cart.fromJson(cartdata);
    //print(product1);
    //print(cartdata);
    cartItems.add(product1);
  });

  store.dispatch(GetcartItemsAction(cartItems));
};

class GetcartItemsAction {
  final List<Cart> _cartItems;

  List<Cart> get cartItems => this._cartItems;

  GetcartItemsAction(this._cartItems);
}

//////
///
///
///
ThunkAction<AppState> clearCartProductsAction = (Store<AppState> store) async {
  store.dispatch(ClearCartProductsAction(List(0)));
};

class ToggleCartProductAction {
  final List<Product> _cartProducts;

  List<Product> get cartProducts => this._cartProducts;

  ToggleCartProductAction(this._cartProducts);
}

class GetCartProductsAction {
  final List<Product> _cartProducts;

  List<Product> get cartProducts => this._cartProducts;

  GetCartProductsAction(this._cartProducts);
}

class ClearCartProductsAction {
  final List<Product> _cartProducts;

  List<Product> get cartProducts => this._cartProducts;

  ClearCartProductsAction(this._cartProducts);
}

/* Cards Actions */
ThunkAction<AppState> getCardsAction = (Store<AppState> store) async {
  final String customerId = store.state.user.customerId.toString();
  http.Response response =
      await http.get('http://localhost:1337/card?$customerId');
  final responseData = json.decode(response.body);
  // print('Card Data: $responseData');
  store.dispatch(GetCardsAction(responseData));
};

class GetCardsAction {
  List<dynamic> _cards;

  List<dynamic> get cards => this._cards;

  GetCardsAction(this._cards);
}

class AddCardAction {
  final dynamic _card;

  dynamic get card => this._card;

  AddCardAction(this._card);
}

/* Card Token Actions */
