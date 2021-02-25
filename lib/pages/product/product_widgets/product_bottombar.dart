//cartbottombar
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/models/user.dart';
import 'package:pawpoint/redux/state/app_state.dart';

Widget productbottombar(context) {
  return (
      //return Text('Hello');
      StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            return Container(
              height: 80,
              color: Colors.black12,
              child: InkWell(
                onTap: () => print('tap on close'),
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                          'Total Price is ${state.ordertotalprice.toString()}'), //state.ordertotalprice
                      RaisedButton(
                        color: Colors.green,
                        onPressed: () {
                          Navigator.pushNamed(context, '/shippingadd');
                        },
                        child: Text(
                          'PROCEED to CHECKOUT',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }));
}
