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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  final void Function() onInit;
  SplashScreen({this.onInit});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  void initState() {
    super.initState();
    widget.onInit();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    // _firebaseMessaging.getToken().then((String token) {
    //   assert(token != null);
    //   setState(() {
    //     _homeScreenText = "Push Messaging token: $token";
    //   });
    //   print(_homeScreenText);
    // });
  }

  void checkperm() async {
    PermissionStatus _permissionStatus;
    _permissionStatus = await Permission.notification.status;
    // Permission.notification.request();
    if (!_permissionStatus.isGranted) {
      await Permission.notification.request();
      // setState(() {});
    }

    // if (await Permission.notification.request().isGranted) {
    //   _permissionStatus = await Permission.notification.status;
    //   setState(() {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen

    checkperm();

    SizeConfig().init(context);
    return (StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            body: AnimatedSplashScreen.withScreenFunction(
              duration: 3000,
              splash: 'assets/images/logo1.png',
              screenFunction: () async {
                return HomePage(onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getCartProductsAction);
                  StoreProvider.of<AppState>(context).dispatch(catProdAction);
                  StoreProvider.of<AppState>(context).dispatch(dogProdAction);
                  StoreProvider.of<AppState>(context).dispatch(servProdAction);
                  StoreProvider.of<AppState>(context).dispatch(bestSellAction);
                });
              },
              // splashTransition: SplashTransition.rotationTransition,
              pageTransitionType: PageTransitionType.scale,
              backgroundColor: Colors.white,
            ),
          );
        }));
  }
}
