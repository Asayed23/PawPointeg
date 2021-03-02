import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/address.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

class FillingAddressPage extends StatefulWidget {
  //Product shippingaddress;
  final ShippingAddress shippingaddress;
  FillingAddressPage({this.shippingaddress});

  @override
  FillingAddressPageState createState() => FillingAddressPageState();
}

class FillingAddressPageState extends State<FillingAddressPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey1 = GlobalKey<FormState>();

  bool _isSubmitting, _obscureText = true;
  String _username, _email, _password;
  List<String> _cities = ['Shekh Zayed', '6 of October'];
  // var _localaddress = new Map();
  var _localaddress = {
    "address_name": "",
    "area": "",
    "street": "",
    "building": "",
    "floor": "",
    "apartment": "",
    "landmark": "",
    "shipping_note": "",
    "address_type": "",
    "city": "",
    "address_id": -1
  };
// _localaddress['city']="Zayed";
  String _city;
  String _area;
  String _street;
  String _building;
  String _floor;
  String _apartment;
  String _landmark;
  String _shipping_note;
  String _addresstype;
  String _address_name;
  String _address_type = "";
  @override
  void initState() {
    setState(() {});

    super.initState();
  }

  Widget _showCityInput(_initialvalue) {
    return DropdownButton(
      hint: Text('Please choose a location'), // Not necessary for Option 1
      value: _city,
      onChanged: (newValue) {
        setState(() {
          _city = newValue;
          _localaddress['city'] = newValue;
        });
      },
      items: _cities.map((location) {
        return DropdownMenuItem(
          child: new Text(location),
          value: location,
        );
      }).toList(),
    );
  }

  Widget _input(_mustbein, _key, _initialvalue) {
    return Container(
        height: h(9),
        margin:
            EdgeInsets.only(top: h(2), left: w(3), bottom: h(1.5), right: w(3)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Color(0xffffffff),
            border: Border.all(width: 1.0, color: const Color(0xffd8d8d)),
            boxShadow: [
              BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(-10, -10),
                blurRadius: 6,
              ),
            ]),
        child: Padding(
            padding: EdgeInsets.only(top: h(0)),
            child: TextFormField(
                onSaved: (val) => _localaddress[_key] = val,
                validator: (val) {
                  return _mustbein
                      ? val.isEmpty
                          ? "Please Enter $_key "
                          : null
                      : null;
                },
                initialValue: _initialvalue,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  labelText: _key,
                  hintText:
                      _mustbein ? 'Please Enter $_key *' : 'Optional $_key',
                ))));
  }

  Widget _showFormActions(userid) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(children: [
          _isSubmitting == true
              ? CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor))
              : Container(
                  // height: h(9),
                  // margin: EdgeInsets.only(top:h(2),left: w(3), bottom: h(1.5), right: w(3)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color(0xffe83636),
                      border: Border.all(
                          width: 1.0, color: const Color(0xffd8d8d8)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(-10, -10),
                          blurRadius: 6,
                        ),
                      ]),

                  child: FlatButton(
                    child: Text('Submit',
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            .copyWith(color: Colors.white)),
                    // elevation: 8.0,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      _submit(userid);
                    },
                  ),
                )
        ]));
  }

  _submit(userid) {
    final form = _formKey1.currentState;
    //_storeaddress(state);

    if (form.validate()) {
      form.save();
      _storeaddress(userid);
    }
  }

  void _storeaddress(userid) async {
    setState(() => _isSubmitting = true);
    print(address_url + '$userid/');
    print(_localaddress['address_id']);

    http.Response response =
        await http.put(address_url + '${userid.toString()}/', body: {
      "shipping_note": _localaddress['shipping_note'],
      "landmark": _localaddress['landmark'],
      "apartment": _localaddress['apartment'],
      "floor": _localaddress['floor'],
      "building": _localaddress['building'],
      "street": _localaddress['street'],
      "area": _localaddress['area'],
      "city": _localaddress['city'],
      "address_name": _localaddress['address_name'],
      "address_type": _localaddress['address_type'],
      "address_id": _localaddress['address_id'].toString(),
    });
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() => _isSubmitting = false);
      _showSuccessSnack();
      _redirectUser();
      print(responseData);
    } else {
      setState(() => _isSubmitting = false);
      final String errorMsg = responseData['message'];
      _showErrorSnack(errorMsg);
    }
  }

  void _showSuccessSnack() {
    final snackbar = SnackBar(
        content: Text(
            'address ${_localaddress['address_name']} successfully created!',
            style: TextStyle(color: Colors.green)));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    _formKey1.currentState.reset();
  }

  void _showErrorSnack(String errorMsg) {
    final snackbar =
        SnackBar(content: Text(errorMsg, style: TextStyle(color: Colors.red)));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    throw Exception('Error address: $errorMsg');
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/shippingadd');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return (StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          if (arguments['new'] == false) {
            _localaddress['address_id'] =
                state.shippingAddress[arguments['index']].address_id;
          }
          // _city =
          //     _localaddress["city"] != null ? _localaddress["city"] : "Zayed";
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(title: Text('Shipping Address')),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey1,
                    child: Column(
                      children: [
                        // _showTitle(),
                        // Text(widget.shippingaddress.id.toString()),
                        _input(
                            true,
                            'address_name',
                            arguments['new']
                                ? null
                                : state.shippingAddress[arguments['index']]
                                    .address_name),
                        _showCityInput(arguments['new']
                            ? 'Shekh Zayed'
                            : state.shippingAddress[arguments['index']]
                                .address_name),
                        _input(
                            false,
                            'area',
                            arguments['new']
                                ? _city
                                : state.shippingAddress[arguments['index']]
                                    .address_name),
                        _input(
                            false,
                            'street',
                            arguments['new']
                                ? null
                                : state.shippingAddress[arguments['index']]
                                    .address_name),

                        // _input(
                        //     false,
                        //     'address_type',
                        //     arguments['new']
                        //         ? null
                        //         : state.shippingAddress[arguments['index']]
                        //             .addresstype),

                        _input(
                            false,
                            'building',
                            arguments['new']
                                ? null
                                : state.shippingAddress[arguments['index']]
                                    .building),
                        _input(
                            false,
                            'floor',
                            arguments['new']
                                ? null
                                : state
                                    .shippingAddress[arguments['index']].floor),
                        _input(
                            false,
                            'apartment',
                            arguments['new']
                                ? null
                                : state.shippingAddress[arguments['index']]
                                    .apartment),
                        _input(
                            false,
                            'landmark',
                            arguments['new']
                                ? null
                                : state.shippingAddress[arguments['index']]
                                    .landmark),
                        _input(
                            false,
                            'shipping_note',
                            arguments['new']
                                ? null
                                : state.shippingAddress[arguments['index']]
                                    .shipping_note),

                        // _input(
                        //     true,
                        //     _area,
                        //     'Area',
                        //     widget.shippingaddress == null
                        //         ? null
                        //         : widget.shippingaddress.area,
                        //     'Please Enter Area'),

                        // _input(
                        //     true,
                        //     _street,
                        //     'Street',
                        //     widget.shippingaddress == null
                        //         ? null
                        //         : widget.shippingaddress.street,
                        //     'Please Enter Street'),
                        // _input(
                        //     true,
                        //     _building,
                        //     'Building',
                        //     widget.shippingaddress == null
                        //         ? null
                        //         : widget.shippingaddress.building,
                        //     'Please Enter Building no'),
                        // _input(
                        //     false,
                        //     _floor,
                        //     'Floor',
                        //     widget.shippingaddress == null
                        //         ? null
                        //         : widget.shippingaddress.floor,
                        //     'Please Enter Floor'),
                        // _input(
                        //     true,
                        //     _apartment,
                        //     'Apartement',
                        //     widget.shippingaddress == null
                        //         ? null
                        //         : widget.shippingaddress.apartment,
                        //     'Please Enter Apartement'),
                        // _input(
                        //     true,
                        //     _landmark,
                        //     'LandMark',
                        //     widget.shippingaddress == null
                        //         ? null
                        //         : widget.shippingaddress.landmark,
                        //     'Please Enter LandMark'),
                        // _input(
                        //     true,
                        //     _shipping_note,
                        //     'shipping_note',
                        //     widget.shippingaddress == null
                        //         ? null
                        //         : widget.shippingaddress.shipping_note,
                        //     'Please Enter shipping_note'),

                        _showFormActions(state.user.id.toString())
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
