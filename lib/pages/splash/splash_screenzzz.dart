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
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        //number of seconds the splash screen will show
        seconds: 7,
        //Page to show after splash screen
        navigateAfterSeconds: HomePage(onInit: () {
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
        }),
        title: new Text(
          'Coding Ninja',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xffe83636),
              fontSize: 30.0),
        ),
        //Our logo that we have imported in step 2
        image: new Image.asset('assets/logo.png'),
        //Splash Screen Background color
        gradientBackground: LinearGradient(
            colors: [Colors.cyan, Colors.blue[100]],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Color(0xffe83636),
      ),
    );
  }
}
