//cartbottombar

import 'package:flutter/material.dart';

import 'package:pawpoint/models/address.dart';
import 'package:pawpoint/size_config.dart';

Widget addbottombar(state, context, selected, _scaffoldKey) {
  //return Text('Hello');
  ShippingAddress _shipaddres;
  print(selected);

  return Container(
    height: h(9),
              margin: EdgeInsets.only(top:h(2),left: w(3), bottom: h(1.5), right: w(3)),
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
              ]),
    
    child: InkWell(
      onTap: () => print('tap on close'),
      child: Padding(
        padding: EdgeInsets.only(top: h(1)),
        child: Column(
          children: <Widget>[
            // Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //    children: [
            //   Text(''),
            // ]), //state.ordertotalprice
            FlatButton(
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(18.0),
              // ),
              // color: Color(0xffe83636),
              onPressed: () {
                if (selected) {
                  Navigator.pushNamed(context, '/paymethod');
                } else {
                  final snackbar = SnackBar(
                      content: Text("Please Select address first",
                          style: TextStyle(color: Color(0xffe83636))));
                  _scaffoldKey.currentState.showSnackBar(snackbar);
                  throw Exception(
                      'Error Address in: "Please Select address first"');
                }
              },
              child: Text(
                'Go to Pay',
                style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: h(3),
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w700,
                                  ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // Container(
  //   margin: EdgeInsets.only(left: w(14), right: w(14)),
  //   decoration: BoxDecoration(
  //     borderRadius: BorderRadius.circular(20),
  //     color: Colors.black,
  //   ),
  //   height: h(14),
  //   child: InkWell(
  //     onTap: () => print('tap on close'),
  //     child: Padding(
  //       padding: EdgeInsets.only(top: 8.0),
  //       child: //state.ordertotalprice
  //           RaisedButton(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(18.0),
  //         ),
  //         color: Colors.orange,
  //         onPressed: () {
  //           Navigator.pushNamed(context, '/paymethod');
  //         },
  //         child: Text(
  //           'Next Last Step',
  //           style: TextStyle(color: Colors.black),
  //         ),
  //       ),
  //     ),
  //   ),
  // );
}
