import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/models/cart.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/pages/order/roder_widgets/order_item.dart';
import 'package:pawpoint/pages/product/product_widgets/product_item.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

import 'dart:convert';

import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/order.dart';

import 'package:http/http.dart' as http;

class OrderDetail extends StatefulWidget {
  Order order;
  OrderDetail({this.order});
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  // Order newOrder;
  // bool _stillloading;
  // getorderdetails() async {
  //   // final List<Product> cartProducts = store.state.cartProducts;
  //   //final double totalprice = store.state.ordertotalprice;
  //   print(orderdetail_url + '${orderid.toString()}/');

  //   http.Response response =
  //       await http.get(orderdetail_url + '${widget.orderid.toString()}/');

  //   final responseData = json.decode(response.body);
  //   //print(responseData);

  //   // create order instance
  //   // List<Order> newOrder = [];
  //   // final responseData1 = responseData['cartid'];
  //   // responseData1.forEach((order1) {
  //   //   final Order _order = Order.fromJson(order1);
  //   //   newOrder.add(_order);
  //   // });

  //   newOrder = Order.fromJson(responseData['cartdata'][0]);
  //   newOrder.products = responseData['products'];
  //   // Get Cart Items
  //   List<Cart> _tempcart = [];
  //   final List<dynamic> _cartdata = responseData['cartitems'];
  //   _cartdata.forEach((_cartitemdata) {
  //     final Cart _cart = Cart.fromJson(_cartitemdata);
  //     _tempcart.add(_cart);
  //   });
  //   // Update Quantity in Products
  //   newOrder.products.forEach((_productdata) {
  //     _tempcart.forEach((_cartdata) {
  //       if (_productdata[0]['id'] == _cartdata.productidId) {
  //         _productdata[0]['quantity'] = _cartdata.quantity;
  //       }
  //     });
  //   });
  //   setState(() => _stillloading = false);

  //   // newOrder.products.forEach((_productdata) {
  //   //   print(_productdata[0]['id']);
  //   //   print(_productdata[0]['name']);
  //   //   print(_productdata[0]['quantity']);
  //   // });
  // }

  // @override
  // void initState() {
  //   _stillloading = true;
  //   getorderdetails();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        final Map arguments = ModalRoute.of(context).settings.arguments as Map;
        widget.order = arguments['order'];
        return Scaffold(
          body: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              new SizedBox(height: 20.0),
              new Container(
                child: new ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return new Column(
                      children: <Widget>[
                        // _maincategory(context),
                        //Divider(),

                        // CircleAvatar(
                        //   radius: w(20),
                        //   child: ClipOval(
                        //     child: Image.asset('assets/images/thanks.jpg'),
                        //   ),
                        // ),
                        //backgroundImage: AssetImage('assets/images/thanks.jpg'),

                        _header('Order ${widget.order.orderNumber}'),
                        // _horizontalListView(state.serviceProducts, 'service'),
                        new SizedBox(height: h(1)),
                        Divider(),
                        // _header(
                        //     'will be delivered to ${state.shippingAddress[newOrder.shippingaddress].address_name}  ${state.shippingAddress[newOrder.shippingaddress].city}'),
                        Divider(),
                        _header(
                            'Order Amount is ${widget.order.totalprice} EGP'),
                        Divider(),
                        _header('Order Items'),
                        _horizontalListView(widget.order.products, 'No'),

                        new SizedBox(height: h(1)),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _horizontalListView(products, target) {
  int cont = products.length;
  return new Container(
    height: h(60),
    child: new ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: cont,
      itemBuilder: (context, index) {
        return new Card(
          elevation: 5.0,
          child: new Container(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              alignment: Alignment.center,
              child: OrderItem(item: products[index][0])),
        );
      },
    ),
  );
}

Widget _header(str) {
  return Container(
      child: Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Text(str,
          style: new TextStyle(
              fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.bold)),
    ),
  ));
}
