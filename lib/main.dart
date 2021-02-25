import 'package:flutter/material.dart';
import 'package:pawpoint/pages/cart/cart_page.dart';
import 'package:pawpoint/pages/contactus/contactus.dart';
import 'package:pawpoint/pages/favorite/favorite_page.dart';
import 'package:pawpoint/pages/home/home_page.dart';
import 'package:pawpoint/pages/login/login_page.dart';
import 'package:pawpoint/pages/order/order_page.dart';
import 'package:pawpoint/pages/paymentmethod/pay_online.dart';
import 'package:pawpoint/pages/paymentmethod/payment_method.dart';
import 'package:pawpoint/pages/product/products_page.dart';
import 'package:pawpoint/pages/register/register_page.dart';
import 'package:pawpoint/pages/search/search.dart';
import 'package:pawpoint/pages/shippingaddress/address_form/filling_address_page.dart';
import 'package:pawpoint/pages/shippingaddress/shipping_add.dart';
import 'package:pawpoint/pages/splash/splash_screen.dart';

import 'package:pawpoint/pages/userprofile/orderhistory/order_details.dart';

import 'package:pawpoint/pages/userprofile/orderhistory/orderhistory.dart';
import 'package:pawpoint/pages/userprofile/userprofile.dart';
import 'package:pawpoint/redux/actions/actions.dart';
import 'package:pawpoint/redux/actions/order_action.dart';
import 'package:pawpoint/redux/actions/add_action.dart';
import 'package:pawpoint/redux/actions/category_action.dart';
import 'package:pawpoint/redux/actions/fav_action.dart';
import 'package:pawpoint/redux/reducers/reducers.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/theme.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';
//import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
  runApp(MyApp(store: store));

  //  DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(store: store), // Wrap your app
  // ),
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return StoreProvider(
        store: store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // locale: DevicePreview.locale(context), // Add the locale here
          // builder: DevicePreview.appBuilder, // Add the builder her
          title: 'Paw Point',
          routes: {
            '/payonline': (BuildContext context) => PayOnline(),
            '/': (BuildContext context) => SplashScreen(onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getProductsAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getCartProductsAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getfavProductsAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getaddressAction);
                  StoreProvider.of<AppState>(context).dispatch(getHistoryOrder);
                  // //getcartItemsAction
                  // StoreProvider.of<AppState>(context)
                  //     .dispatch(getcartItemsAction);
                  StoreProvider.of<AppState>(context).dispatch(catProdAction);
                  StoreProvider.of<AppState>(context).dispatch(dogProdAction);
                  StoreProvider.of<AppState>(context).dispatch(servProdAction);
                  StoreProvider.of<AppState>(context).dispatch(bestSellAction);
                  // StoreProvider.of<AppState>(context)
                  //     .dispatch(dogProdAction);
                }),
            //ForgotPasswordScreen(), //CompleteProfileScreen(), //
            '/home': (BuildContext context) => HomePage(onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getCartProductsAction);
                  StoreProvider.of<AppState>(context).dispatch(catProdAction);
                  StoreProvider.of<AppState>(context).dispatch(dogProdAction);
                  StoreProvider.of<AppState>(context).dispatch(servProdAction);
                  StoreProvider.of<AppState>(context).dispatch(bestSellAction);
                }),
            '/products': (BuildContext context) => ProductsPage(onInit: () {
                  StoreProvider.of<AppState>(context)
                      .dispatch(UpdateShowProduct(null));
                }),

            '/login': (BuildContext context) => LoginPage(),
            '/register': (BuildContext context) => RegisterPage(),
            '/cart': (BuildContext context) => CartPage(),
            '/order': (BuildContext context) => OrderPage(onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getHistoryOrder);
                }),
            '/favorite': (BuildContext context) => FavPage(),
            '/shippingadd': (BuildContext context) => ShippingAdd(onInit: () {
                  StoreProvider.of<AppState>(context)
                      .dispatch(getaddressAction);
                }),
            '/filladdress': (BuildContext context) => FillingAddressPage(),
            '/paymethod': (BuildContext context) => PaymentMethodPage(),
            '/profile': (BuildContext context) => UserProfile(),
            '/contactus': (BuildContext context) => Contactus(),
            '/search': (BuildContext context) => SearchPage(),

            //'/testpage': (BuildContext context) => TestPage(),
            '/orderHistory': (BuildContext context) => OrderHistory(onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getHistoryOrder);
                }),

            '/orderDetial': (BuildContext context) => OrderDetail(),
          },
          theme: theme(),
        ));
  }
}
