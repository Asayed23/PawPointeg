import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/models/enums.dart';
import 'package:pawpoint/pages/common/bottombar.dart';
import 'package:pawpoint/pages/favorite/fav_widgets/fav_body.dart';
import 'package:pawpoint/redux/state/app_state.dart';
// import 'package:flutter_ecommerce/widgets/cart_widget/cart_body.dart';
// import 'package:flutter_ecommerce/widgets/cart_widget/cart_bottombar.dart';

class FavPage extends StatefulWidget {
  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: state.favProducts.length > 0
                ? Text(
                    'Your Favorite items are ${state.favProducts.length} items ')
                : Text('Empty Favorite Items'),
          ),
          body: state.inloading.allproduct
              ? Container(
                height: 20,
                  child: Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).accentColor)),
                ))
              : favbody(state, context),
          bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.fav),
          // bottomNavigationBar: cartbottombar(state, context),
        );
      },
    ));
  }
}
