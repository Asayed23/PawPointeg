import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:loading_animations/loading_animations.dart';

import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/order.dart';
import 'package:pawpoint/pages/common/theappbar.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'package:pawpoint/models/cart.dart';

import 'dart:convert';

class OrderHistory extends StatefulWidget {
  final void Function() onInit;
  OrderHistory({this.onInit});
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  void initState() {
    _stillloading = false;
    super.initState();
    widget.onInit();
  }

  Order newOrder;
  bool _stillloading;
  getorderdetails(orderid) async {
    // final List<Product> cartProducts = store.state.cartProducts;
    //final double totalprice = store.state.ordertotalprice;
    print(orderdetail_url + '${orderid.toString()}/');

    http.Response response =
        await http.get(orderdetail_url + '${orderid.toString()}/');

    final responseData = json.decode(response.body);
    //print(responseData);

    // create order instance
    // List<Order> newOrder = [];
    // final responseData1 = responseData['cartid'];
    // responseData1.forEach((order1) {
    //   final Order _order = Order.fromJson(order1);
    //   newOrder.add(_order);
    // });

    newOrder = Order.fromJson(responseData['cartdata'][0]);
    newOrder.products = responseData['products'];
    // Get Cart Items
    List<Cart> _tempcart = [];
    final List<dynamic> _cartdata = responseData['cartitems'];
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
    setState(() => _stillloading = false);

    Navigator.pushNamed(context, '/orderDetial',
        arguments: {'order': newOrder});

    // newOrder.products.forEach((_productdata) {
    //   print(_productdata[0]['id']);
    //   print(_productdata[0]['name']);
    //   print(_productdata[0]['quantity']);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          print(state.user.id);
          return Scaffold(
            appBar: theappBar(context, 'My Orders'),
            body: _stillloading
                ? AlertDialog(
                    title: Text('......Please Wait..'),
                    content:
                        Container(width: 32, child: LoadingRotating.square()))
                : ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: <Widget>[
                      new SizedBox(height: 10.0),
                      new Container(
                        child: new ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.orders.length,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            print(state.orders[index].id);
                            return Container(
                                height: h(14),
                                margin: EdgeInsets.only(
                                    top: h(2),
                                    left: w(3),
                                    bottom: h(1.5),
                                    right: w(3)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Color(0xffffffff),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0xffd8d8d8)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x29000000),
                                      offset: Offset(-10, -10),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                child: new Column(
                                  children: <Widget>[
                                    // _maincategory(context),
                                    //Divider(),

                                    ListTile(
                                        leading: Text(
                                            state.orders[index].orderNumber),
                                        title: Text(
                                            "${state.orders[index].totalprice.toString()} EGP"),
                                        subtitle: Text(
                                            state.orders[index].order_date),
                                        trailing: state.orders[index]
                                                    .orderStatus ==
                                                'Rejected'
                                            ? Text(
                                                state.orders[index].orderStatus,
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )
                                            : Text(state
                                                .orders[index].orderStatus),
                                        //isThreeLine: true,
                                        onTap: () {
                                          setState(() => _stillloading = true);
                                          getorderdetails(
                                              state.orders[index].id);
                                        }
                                        // Navigator.pushNamed(context, '/orderDetial'),

                                        ),
                                    // Divider(),

                                    // new SizedBox(height: h(1)),
                                  ],
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
          );
        }));
  }
}

Widget _header(str) {
  return Container(
      child: Align(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Text(str,
          style: new TextStyle(
              fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.bold)),
    ),
  ));
}

_launchURL(urllink) async {
  //const url = urllink;

  if (await canLaunch(urllink)) {
    await launch(urllink);
  } else {
    throw 'Could not launch $urllink';
  }
}
