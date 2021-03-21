import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/cart.dart';
import 'package:pawpoint/models/order.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/models/user.dart';
import 'package:pawpoint/pages/order/order_page.dart';
import 'package:pawpoint/redux/actions/inloading_action.dart';
import 'package:pawpoint/redux/actions/order_action.dart';
import 'package:pawpoint/redux/actions/actions.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:http/http.dart' as http;
import 'package:pawpoint/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  int value;
  bool showload, _error;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    showload = false;
    _error = false;
    super.initState();
  }

  String totalPrice, payUrl;
  String email;
  String first_name;
  String phone_number;
  String last_name;
  String _payToken;

  prepareToken() async {
    //// Token
    Map data = {'api_key': api_key};
    var body = json.encode(data);
    var response = await http.post(token_url,
        headers: {"Content-Type": "application/json"}, body: body);
    var responseData = json.decode(response.body);
    print(token_url);
    print(body);
    print(responseData);
    if (response.statusCode == 201) {
      String token = responseData['token'];
      // Order id
      data = {
        "auth_token": token,
        "delivery_needed": "false",
        "amount_cents": totalPrice,
        "currency": "EGP",
        "items": []
      };
      body = json.encode(data);
      response = await http.post(order_url,
          headers: {"Content-Type": "application/json"}, body: body);
      responseData = json.decode(response.body);
      print(order_url);
      print(body);
      print(responseData);
      if (response.statusCode == 201) {
        // Pay Token
        String order_id = responseData['id'].toString();
        data = {
          "auth_token": token,
          "amount_cents": totalPrice,
          "expiration": 3600,
          "order_id": order_id,
          "billing_data": {
            "apartment": "NA",
            "email": email,
            "floor": "NA",
            "first_name": first_name,
            "street": "NA",
            "building": "NA",
            "phone_number": phone_number,
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "last_name": first_name,
            "state": "NA"
          },
          "currency": "EGP",
          "integration_id": 118644,
          "lock_order_when_paid": "false"
        };

        body = json.encode(data);
        response = await http.post(pay_url,
            headers: {"Content-Type": "application/json"}, body: body);
        responseData = json.decode(response.body);
        print(pay_url);
        print(body);
        print(responseData);

        if (response.statusCode == 201) {
          _payToken = responseData['token'];
          setState(() {
            _error = false;
            showload = false;
            payUrl =
                'https://accept.paymobsolutions.com/api/acceptance/iframes/$iframe?payment_token=$_payToken';
          });
          Navigator.pushNamed(context, '/payonline',
              arguments: {'payUrl': payUrl});
          print(payUrl);
          return payUrl;
        } else {
          setState(() {
            showload = false;
            _error = true;
          });
        }
      } else {
        setState(() {
          showload = false;
          _error = true;
        });
      }
    } else {
      setState(() {
        showload = false;
        _error = true;
      });
    }

    setState(() {
      showload = false;
      _error = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          totalPrice = (state.currentorder.totalprice * 100).toString();
          first_name = state.user.full_name;
          email = state.user.email;
          phone_number = '0${(state.user.phone_number).toString()}';
          Order _order;
          // Order _order = Order();
          _order = state.currentorder;
          // value = 0;
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: state.cartProducts.length > 0
                  ? Text(
                      'Payment Method',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 25,
                        color: const Color(0xffe83636),
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : Text(
                      'No Order yet',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 25,
                        color: const Color(0xffe83636),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: ListView(children: [
              ListTile(
                  title: Text(
                    'Select Your Payment Method',
                    style: TextStyle(color: Colors.red),
                  ),
                  //trailing: Icon(Icons.add),
                  onTap: () {}),
              RadioListTile(
                value: 0,
                groupValue: value,
                onChanged: (ind) {
                  setState(() {
                    _error = false;
                    showload = false;
                    value = ind;
                  });
                  _order.paymentMethod = "Cash on Delivery";
                  StoreProvider.of<AppState>(context)
                      .dispatch(Updatecurrentorder(_order));
                  state.inloading.selected = true;
                  StoreProvider.of<AppState>(context)
                      .dispatch(UpdateInloading(state.inloading));

                  // state.shippingAddress[index].selected = true;
                },
                activeColor: Colors.red,
                title: Row(children: [
                  Text('Cash on Delivery'),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.monetization_on_sharp,
                      color: Colors.green,
                    ),
                  )
                ]),
              ),
              // RadioListTile(
              //   value: 1,
              //   groupValue: value,
              //   onChanged: (ind) {
              //     setState(() => value = ind);

              //     _order.paymentMethod = "using Bank Card";
              //     StoreProvider.of<AppState>(context)
              //         .dispatch(Updatecurrentorder(_order));
              //     state.inloading.selected = true;
              //     StoreProvider.of<AppState>(context)
              //         .dispatch(UpdateInloading(state.inloading));
              //     // state.shippingAddress[index].selected = true;
              //   },
              //   activeColor: Colors.red,
              //   title: Row(children: [
              //     Text('using Bank Card'),
              //     Padding(
              //       padding: const EdgeInsets.only(left: 8.0),
              //       child: Icon(
              //         Icons.credit_card,
              //         color: Colors.red,
              //       ),
              //     )
              //   ]),
              // ),
              if (showload)
                AlertDialog(
                    title: Text('We are working......Please Wait..'),
                    content:
                        Container(width: 32, child: LoadingRotating.square())),
              if (_error)
                Container(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'There is an error in Online Payment server , please try again or select cash on delivery option at this moment. '),
                )),
            ]),
            bottomNavigationBar: Container(
              height: h(9),
              margin: EdgeInsets.only(left: w(3), bottom: h(1.5), right: w(3)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Color(0xffe83636),
                border: Border.all(width: 1.0, color: const Color(0xffd8d8d8)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(-10, -10),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () => print('tap on close'),
                child: Padding(
                  padding: EdgeInsets.only(top: 0.0),

                  //state.ordertotalprice
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: Color(0xffe83636),
                    onPressed: () {
                      if (state.inloading.selected) {
                        setState(() => showload = true);
                        state.inloading.selected = false;
                        StoreProvider.of<AppState>(context)
                            .dispatch(UpdateInloading(state.inloading));
                        if (_order.paymentMethod == "Cash on Delivery") {
                          storeorderindb(state, context);
                        } else {
                          prepareToken();

                          //Navigator.pushReplacementNamed(context, '/payonline');
                        }
                      } else {
                        final snackbar = SnackBar(
                            content: Text("Select your prefered Payment Method",
                                style: TextStyle(color: Colors.red)));
                        _scaffoldKey.currentState.showSnackBar(snackbar);
                      }
                      // Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             OrderPage()));
                    },
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 20,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}

storeorderindb(state, context) async {
  // final List<Product> cartProducts = store.state.cartProducts;
  //final double totalprice = store.state.ordertotalprice;
  final User user = state.user;
  var x = {
    //"id": json.encode(cartProduct.id),

    "shippingaddress": json.encode(state.currentorder.shippingaddress),
    "payment_method": state.currentorder.paymentMethod,
    "total_price": json.encode(state.currentorder.totalprice),
    //"payid": state.currentorder.payid,
    "order_status": 'In progess'
  };
  print(x);
  http.Response response = await http.post(cart_url + '${user.cartId}/',
      // body: {"products": json.encode(cartProductsIds)},
      body: {
        //"id": json.encode(cartProduct.id),

        "shippingaddress": json.encode(state.currentorder.shippingaddress),
        "payment_method": state.currentorder.paymentMethod,
        "total_price": json.encode(state.currentorder.totalprice),
        "order_status": 'ordered'
      }, headers: {
    "Authorization": "Bearer ${user.jwt}"
  });
  print('reading done.......................');
  final responseData = json.decode(response.body);
  print(responseData);

  // create order instance
  // List<Order> newOrder = [];
  // final responseData1 = responseData['cartid'];
  // responseData1.forEach((order1) {
  //   final Order _order = Order.fromJson(order1);
  //   newOrder.add(_order);
  // });

  Order newOrder = Order.fromJson(responseData['cartid'][0]);
  newOrder.products = responseData['products'];

  // Get Cart Items
  List<Cart> _tempcart = [];
  final List<dynamic> _cartdata = responseData['cartdata'];
  _cartdata.forEach((_cartitemdata) {
    final Cart _cart = Cart.fromJson(_cartitemdata);
    _tempcart.add(_cart);
  });
  // Update Quantity in Products
  newOrder.products.forEach((_productdata) {
    _tempcart.forEach((_cartdata) {
      if (_productdata[0]['id'] == _cartdata.productidId) {
        _productdata[0]['quantity'] = _cartdata.quantity;
      }
    });
  });

  // pass order instance to a new action (AddOrderAction)
  // Save New Order
  //int _ind = newOrder.indexWhere((order) => order.id == user.cartId);

  StoreProvider.of<AppState>(context).dispatch(Updatecurrentorder(newOrder));
///////////////// clear old cart /////////////
  StoreProvider.of<AppState>(context).dispatch(ClearCartProductsAction);

  User _user = state.user;

  _user.cartId = responseData['new_cartid'];
  StoreProvider.of<AppState>(context).dispatch(UpdateUserAction(_user));

  final prefs = await SharedPreferences.getInstance();

  prefs.setString('user', json.encode(state.user));

  Navigator.pushReplacementNamed(context, '/order');
}
