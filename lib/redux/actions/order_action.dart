import 'package:pawpoint/models/order.dart';

import 'dart:convert';
import 'package:pawpoint/db_links/db_links.dart';

import 'package:http/http.dart' as http;

import 'package:pawpoint/models/user.dart';
import 'package:pawpoint/redux/actions/inloading_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* Orders Actions */
class AddOrderAction {
  final Order _order;

  Order get order => this._order;

  AddOrderAction(this._order);
}

class Updatecurrentorder {
  final Order _order;

  Order get order => this._order;

  Updatecurrentorder(this._order);
}

ThunkAction<AppState> getHistoryOrder = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString('user');
  if (storedUser == null) {
    return;
  }
  final User user = User.fromJson(json.decode(storedUser));
  http.Response response = await http.get(orderhist_url + '/${user.id}/',
      headers: {'Authorization': 'Bearer ${user.jwt}'});

  final responseData = json.decode(response.body);
  //['Orders'];

  List<Order> orders = [];
  responseData.forEach((_orderData) {
    final Order _order = Order.fromJson(_orderData);
    orders.add(_order);
  });
  store.dispatch(GetHistoryOrder(orders));
};

class GetHistoryOrder {
  final List<Order> _orders;

  List<Order> get orders => this._orders;

  GetHistoryOrder(this._orders);
}
