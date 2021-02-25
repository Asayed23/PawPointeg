//cartbottombar
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/redux/actions/actions.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

Widget orderbottombar(state, context, _order) {
  //return Text('Hello');

  return Container(
                height:h(9),
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
        child: 
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Color(0xffe83636),
              onPressed: () {
                StoreProvider.of<AppState>(context)
                    .dispatch(getCartProductsAction);
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text(
                'Home Page',
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
    
  );
}
