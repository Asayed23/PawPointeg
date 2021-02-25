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

class SplashScreen extends StatefulWidget {
  final void Function() onInit;
  SplashScreen({this.onInit});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return (StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            body: AnimatedSplashScreen.withScreenFunction(
              duration: 3000,
              splash: 'assets/images/ic_launcher.png',
              screenFunction: () async {
                return HomePage();
              },
              splashTransition: SplashTransition.rotationTransition,
              pageTransitionType: PageTransitionType.scale,
              backgroundColor: Colors.white,
            ),
          );
        }));
  }
}
