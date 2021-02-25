import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/models/address.dart';
import 'package:pawpoint/pages/shippingaddress/address_form/filling_address_page.dart';
import 'package:pawpoint/redux/actions/order_action.dart';

import 'package:pawpoint/redux/state/app_state.dart';

class Addbody extends StatefulWidget {
  ShippingAddress selected;

  Addbody({this.selected});
  @override
  _AddbodyState createState() => _AddbodyState();
}

class _AddbodyState extends State<Addbody> {
  ShippingAddress value;
  // @override
  // void initState() {
  //   setState(() {
  //     Future.delayed(Duration(seconds: 2), () {
  //       value = widget.selected;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          // value = state.shippingAddress[0];
          return SafeArea(
            minimum: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                          title: Text(
                            'Select Your Adress',
                            style: TextStyle(color: Colors.red),
                          ),
                          trailing: state.shippingAddress.length < 2
                              ? Icon(Icons.add)
                              : Icon(Icons.location_on_sharp),
                          onTap: () {
                            if (state.shippingAddress.length < 2) {
                              ShippingAddress _shipaddres;
                              Navigator.pushNamed(context, '/filladdress',
                                  arguments: {'new': true, 'index': 1000});
                            }
                          })),
                ),
                state.shippingAddress.length == 0
                    ? Container(
                        child: Center(
                            child: Text('Please add your address first')),
                      )
                    : Container(
                        height: 500,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return RadioListTile(
                              value: state.shippingAddress[index],
                              groupValue: value,
                              activeColor: Colors.red,
                              onChanged: (ind) {
                                setState(() {
                                  //widget.selected = true;
                                  return value = ind;
                                });

                                state.currentorder.shippingaddress =
                                    state.shippingAddress[index].address_id;
                                StoreProvider.of<AppState>(context).dispatch(
                                    Updatecurrentorder(state.currentorder));
                                // state.shippingAddress[index].selected = true;
                              },
                              title: Text(
                                state.shippingAddress[index].address_name,
                              ),
                              subtitle: Text(
                                  '${state.shippingAddress[index].area} city ${state.shippingAddress[index].city} Building ${state.shippingAddress[index].building} Stree ${state.shippingAddress[index].street}'),
                              isThreeLine: true,
                              secondary: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/filladdress',
                                      arguments: {
                                        'new': false,
                                        'index': index
                                      });
                                },
                                child: Text('Edit'),
                              ),
                            );
                          },
                          itemCount:
                              state.shippingAddress.length, //shippingAddress
                        ),
                      ),
              ]),
            ),
          );
        }));
  }

  // @override
  // Widget build(BuildContext context) {

  //   return (StoreConnector<AppState, AppState>(
  //     converter: (store) => store.state,
  //     builder: (context, state) {
  //       return Column(children: [
  //         // Text('Sipping address'),
  //         // state.shippingAddress.length < 2
  //         //     ? FlatButton(
  //         //         child: Text('Add'),
  //         //         onPressed: () => Navigator.pushReplacementNamed(
  //         //             context, '/addressfilling'))
  //         //     : Text(''),
  //         Expanded(
  //           child: SafeArea(
  //             top: false,
  //             bottom: false,
  //             child: GridView.builder(
  //               itemCount: state.cartProducts.length,
  //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 1,
  //                   // crossAxisSpacing: 1.0,
  //                   // mainAxisSpacing: 1.0,
  //                   childAspectRatio: 4),
  //               itemBuilder: (context, index) {
  //                 return AddItem(
  //                     item: state.cartProducts[index],
  //                     index: index); //shippingAddress
  //               },
  //             ),
  //           ),
  //         )
  //       ]);
  //     },
  //   ));
  // }
}
