import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/pages/order/roder_widgets/order_item.dart';
import 'package:pawpoint/pages/product/product_widgets/product_item.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

class Orderbody extends StatefulWidget {
  @override
  _OrderbodyState createState() => _OrderbodyState();
}

class _OrderbodyState extends State<Orderbody> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return ListView(
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

                      CircleAvatar(
                        radius: w(20),
                        child: ClipOval(
                          child: Image.asset('assets/images/thanks.jpg'),
                        ),
                      ),
                      //backgroundImage: AssetImage('assets/images/thanks.jpg'),

                      _header(
                          'Your Order is ${state.currentorder.orderNumber}'),
                      // _horizontalListView(state.serviceProducts, 'service'),
                      new SizedBox(height: h(1)),
                      Divider(),
                      // _header(
                      //     'will be delivered to ${state.shippingAddress[state.currentorder.shippingaddress].address_name}  ${state.shippingAddress[state.currentorder.shippingaddress].city}'),
                      Divider(),
                      _header(
                          'Total Price is ${state.currentorder.totalprice} EGP'),
                      Divider(),
                      _header('Your Order Items are'),
                      _horizontalListView(state.currentorder.products, 'No'),

                      new SizedBox(height: h(1)),
                    ],
                  );
                },
              ),
            ),
          ],
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
