import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/models/address.dart';
import 'package:pawpoint/pages/shippingaddress/address_widgets/add_body.dart';
import 'package:pawpoint/pages/shippingaddress/address_widgets/add_bottombar.dart';
import 'package:pawpoint/redux/actions/order_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

class ShippingAdd extends StatefulWidget {
  final void Function() onInit;
  ShippingAdd({this.onInit});
  @override
  _ShippingAddState createState() => _ShippingAddState();
}

class _ShippingAddState extends State<ShippingAdd> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ShippingAddress value;
  bool selected = false;

  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
            title: state.shippingAddress.length > 0
                ? Center(
            child:Text('Delivery Address',
                style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 25,
            color: const Color(0xffe83636),
            fontWeight: FontWeight.w700,
          )))
                : Center(
            child:Text('Add your Address',
                style: TextStyle(
                                  color: Colors.black, fontSize: h(2.9)),
                            )),
          ),
          //body: Addbody(),
          body: state.inloading.address
              ? Container(
                  child: Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).accentColor)),
                ))
              : SafeArea(
                  minimum: const EdgeInsets.only(top:20,left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xffd8d8d8)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(-10, -10),
                  blurRadius: 6,
                ),
              ]),
                            
                            child: Padding(
                              
                                padding: const EdgeInsets.all(10.0),
                                child: ListTile(
                                    title: Text(
                                      'Select Delivery Address',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    trailing: state.shippingAddress.length < 2
                                        ? Icon(Icons.add)
                                        : Icon(Icons.location_on_sharp),
                                    onTap: () {
                                      if (state.shippingAddress.length < 2) {
                                        ShippingAddress _shipaddres;
                                        Navigator.pushNamed(
                                            context, '/filladdress',
                                            arguments: {
                                              'new': true,
                                              'index': 1000
                                            });
                                      }
                                    })),
                          ),
                          state.shippingAddress.length == 0
                              ? Container(
                                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xffd8d8d8)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(-10, -10),
                  blurRadius: 6,
                ),
              ]),
                                  child: Center(
                                      child: Text(
                                          'Please add your address first')),
                                )
                              : Container(
                                
                                  height: 500,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Padding(
                          padding: EdgeInsets.only(
                              top: h(5), left: w(0), right: w(0)),
                          child:Container(
                                        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xffd8d8d8)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(-10, -10),
                  blurRadius: 6,
                ),
              ]),
              child:RadioListTile(
                                        value: state.shippingAddress[index],
                                        groupValue: value,
                                        activeColor: Colors.red,
                                        onChanged: (ind) {
                                          setState(() {
                                            //widget.selected = true;
                                            selected = true;
                                            return value = ind;
                                          });

                                          state.currentorder.shippingaddress =
                                              state.shippingAddress[index]
                                                  .address_id;
                                          StoreProvider.of<AppState>(context)
                                              .dispatch(Updatecurrentorder(
                                                  state.currentorder));
                                          // state.shippingAddress[index].selected = true;
                                        },
                                        title: Text(
                                          state.shippingAddress[index]
                                              .address_name,
                                        ),
                                        subtitle: Text(
                                            'area ${state.shippingAddress[index].area} city ${state.shippingAddress[index].city} Building ${state.shippingAddress[index].building} Stree ${state.shippingAddress[index].street}'),
                                        isThreeLine: true,
                                        secondary: TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/filladdress',
                                                arguments: {
                                                  'new': false,
                                                  'index': index
                                                });
                                          },
                                          child: Text('Edit'),
                                        ),
                                      )));
                                    },
                                    itemCount: state.shippingAddress
                                        .length, //shippingAddress
                                  ),
                                ),
                        ]),
                  ),
                ),
          bottomNavigationBar:
              addbottombar(state, context, selected, _scaffoldKey),
        );
      },
    ));
  }
}
