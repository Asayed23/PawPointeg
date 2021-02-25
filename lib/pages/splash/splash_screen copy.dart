import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pawpoint/pages/home/home_page.dart';
import 'package:pawpoint/pages/product/products_page.dart';
import 'package:pawpoint/redux/actions/actions.dart';
import 'package:pawpoint/redux/actions/add_action.dart';
import 'package:pawpoint/redux/actions/category_action.dart';
import 'package:pawpoint/redux/actions/fav_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
        body: AnimatedSplashScreen.withScreenFunction(
      splash: 'assets/images/logo.png',
      screenFunction: () async {
        return HomePage(onInit: () {
          StoreProvider.of<AppState>(context).dispatch(getUserAction);
          StoreProvider.of<AppState>(context).dispatch(getProductsAction);
          StoreProvider.of<AppState>(context).dispatch(catProdAction);
          StoreProvider.of<AppState>(context).dispatch(getCartProductsAction);
          StoreProvider.of<AppState>(context).dispatch(getfavProductsAction);
          StoreProvider.of<AppState>(context).dispatch(getaddressAction);

          StoreProvider.of<AppState>(context).dispatch(dogProdAction);
          StoreProvider.of<AppState>(context).dispatch(servProdAction);
          StoreProvider.of<AppState>(context).dispatch(bestSellAction);

          // StoreProvider.of<AppState>(context).dispatch(getCartProductsAction);
          //getcartItemsAction
          // StoreProvider.of<AppState>(context).dispatch(getcartItemsAction);
        });
      },
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.scale,
      backgroundColor: const Color(0xffe83636),
    ));
  }
}
