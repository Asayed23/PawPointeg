import 'dart:convert';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/product.dart';
import 'package:http/http.dart' as http;

import 'package:pawpoint/models/user.dart';
import 'package:pawpoint/redux/actions/inloading_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThunkAction<AppState> toggleFavProductAction(Product favProduct) {
  return (Store<AppState> store) async {
    final List<Product> favProducts = store.state.favProducts;
    final User user = store.state.user;
    final int index =
        favProducts.indexWhere((product) => product.id == favProduct.id);
    //final int pos = favProducts.length;

    bool isInCart = index > -1 == true;
    List<Product> updatedFavProducts = List.from(favProducts);
    if (isInCart == false) {
      updatedFavProducts.add(favProduct);
      updatedFavProducts.map((product) => product.id).toList();

      var x = await http.put(fav_url + '${user.favourite_id}/',
          // body: {"products": json.encode(cartProductsIds)},
          body: {
            //"id": json.encode(cartProduct.id),
            "productid": json.encode(favProduct.id),
          }, headers: {
        "Authorization": "Bearer ${user.jwt}"
      });

      // storefavindb(favProduct);
    } else {
      updatedFavProducts.removeAt(index);

      var x = await http.put(fav_url + '${user.favourite_id}/',
          // body: {"products": json.encode(cartProductsIds)},
          body: {
            //"id": json.encode(cartProduct.id),
            "productid": json.encode(favProduct.id),
          }, headers: {
        "Authorization": "Bearer ${user.jwt}"
      });
      // storefavindb(favProduct);
    }
    store.dispatch(ToggleFavProductAction(updatedFavProducts));
    store.state.inloading.favproduct = false;
    store.dispatch(UpdateInloading(store.state.inloading));
  };
}

class ToggleFavProductAction {
  final List<Product> _favProducts;

  List<Product> get favProducts => this._favProducts;

  ToggleFavProductAction(this._favProducts);
}

// storefavindb(favProducts) {
//   return (Store<AppState> store) async {
//     final User user = store.state.user;
//     print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
//     print(fav_url + '${user.favourite_id}/');
//     var x = await http.put(fav_url + '${user.favourite_id}/',
//         // body: {"products": json.encode(cartProductsIds)},
//         body: {
//           //"id": json.encode(cartProduct.id),
//           "productid": json.encode(favProducts.id),
//         }, headers: {
//       "Authorization": "Bearer ${user.jwt}"
//     });
//   };
// }

ThunkAction<AppState> getfavProductsAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString('user');
  if (storedUser == null) {
    store.dispatch(GetFavProductsAction([]));
    return;
  }
  final User user = User.fromJson(json.decode(storedUser));
  http.Response response = await http.get(fav_url + '/${user.favourite_id}/',
      headers: {'Authorization': 'Bearer ${user.jwt}'});

  final responseData = json.decode(response.body);
  //['products'];

  List<Product> favProducts = [];
  responseData.forEach((productData) {
    final Product product = Product.fromJson(productData);
    favProducts.add(product);
  });
  store.dispatch(GetFavProductsAction(favProducts));
};

class GetFavProductsAction {
  final List<Product> _favProducts;

  List<Product> get favProducts => this._favProducts;

  GetFavProductsAction(this._favProducts);
}
