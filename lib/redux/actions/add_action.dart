import 'dart:convert';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/address.dart';
import 'package:http/http.dart' as http;

import 'package:pawpoint/models/user.dart';
import 'package:pawpoint/redux/actions/inloading_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> getaddressAction = (Store<AppState> store) async {
  String userid = store.state.user.id.toString();
  print(address_url + '$userid/');
  print('===========================================gettting ========');

  store.state.inloading.address = true;
  store.dispatch(UpdateInloading(store.state.inloading));

  http.Response response = await http.get(address_url + '$userid/');

  final List<dynamic> responseData = json.decode(response.body);

  List<ShippingAddress> adresss = [];
  responseData.forEach((addressData) {
    final ShippingAddress addres = ShippingAddress.fromJson(addressData);
    adresss.add(addres);
  });
  store.dispatch(GetAddAction(adresss));
  store.state.inloading.address = false;
  store.dispatch(UpdateInloading(store.state.inloading));
};

class GetAddAction {
  final List<ShippingAddress> _adresss;

  List<ShippingAddress> get adresss => this._adresss;

  GetAddAction(this._adresss);
}

ThunkAction<AppState> addadressAction = (Store<AppState> store) async {
  final User user = store.state.user;
  final List<ShippingAddress> addresses = store.state.shippingAddress;
  await http.put('http://localhost:1337/carts/${user.cartId}',
      body: {"products": json.encode([])},
      headers: {'Authorization': "Bearer ${user.jwt}"});
  store.dispatch(AddadressAction(addresses));
};

class AddadressAction {
  final List<ShippingAddress> _adresss;

  List<ShippingAddress> get adresss => this._adresss;

  AddadressAction(this._adresss);
}
