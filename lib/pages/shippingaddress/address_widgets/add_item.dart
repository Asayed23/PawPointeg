import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/redux/state/app_state.dart';

class AddItem extends StatefulWidget {
  //final ShippingAddress item;
  final Product item;
  final int index;
  AddItem({this.item, this.index});

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  // ShippingAddress value;
  int value;
  dynamic i;

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return RadioListTile(
            value: widget.index,
            groupValue: value,
            onChanged: (ind) {
              setState(() => value = ind);
              state.currentorder.shippingaddress = widget.index;
              // StoreProvider.of<AppState>(context).dispatch(state.currentorder);
            },
            title: Text("Number $widget.index"),
          );
        }));
  }
}
