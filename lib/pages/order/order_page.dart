import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/models/order.dart';
import 'package:pawpoint/pages/order/roder_widgets/order_body.dart';
import 'package:pawpoint/pages/order/roder_widgets/order_bottombar.dart';
import 'package:pawpoint/redux/state/app_state.dart';

class OrderPage extends StatefulWidget {
  final void Function() onInit;
  OrderPage({this.onInit});
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  void initState() {
    super.initState();
    widget.onInit();
  }
  //final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to got to Home Page'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        Order _order;
        // Order _order = Order();
        _order = state.currentorder;
        return WillPopScope(
          //onWillPop: _onWillPop,
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              
              elevation: 0.0,
              
              backgroundColor: Colors.white,
              
              centerTitle: true,
              title: state.cartProducts.length > 0
                  ? Text('Order Summary',style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 25,
            color: const Color(0xffe83636),
            fontWeight: FontWeight.w700,
          ),)
                  : Text('No Order yet',style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 25,
            color: const Color(0xffe83636),
            fontWeight: FontWeight.w700,
          ),),
            ),
            body: Orderbody(),
            bottomNavigationBar: orderbottombar(state, context, _order),
          ),
        );
      },
    ));
  }
}
