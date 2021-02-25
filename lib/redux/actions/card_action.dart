import 'dart:convert';
import 'package:pawpoint/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> getCardTokenAction = (Store<AppState> store) async {
  final String jwt = store.state.user.jwt;
  http.Response response = await http.get('http://localhost:1337/users/me',
      headers: {'Authorization': 'Bearer $jwt'});
  final responseData = json.decode(response.body);
  List<Order> orders = [];
  responseData['orders'].forEach((orderData) {
    final Order order = Order.fromJson(orderData);
    orders.add(order);
  });
  final String cardToken = responseData['card_token'];
  store.dispatch(GetCardTokenAction(cardToken));
  store.dispatch(GetOrdersAction(orders));
};

class GetOrdersAction {
  final List<Order> _orders;

  List<Order> get orders => this._orders;

  GetOrdersAction(this._orders);
}

class UpdateCardTokenAction {
  final String _cardToken;

  String get cardToken => this._cardToken;

  UpdateCardTokenAction(this._cardToken);
}

class GetCardTokenAction {
  final String _cardToken;

  String get cardToken => this._cardToken;

  GetCardTokenAction(this._cardToken);
}
