import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

Widget productabbbar(context) {
  return PreferredSize(
      // to increase appbar size
      preferredSize: Size.fromHeight(60.0),
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return AppBar(
              bottom: PreferredSize(
                child: Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Row(children: [
                    Text(
                      "Paw Point",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
                preferredSize: Size.fromHeight(60.0),
              ),
              //leading: Icon(Icons.menu),

              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Transform.rotate(
                      angle: 30 * 3.14 / 180,
                      child: Icon(
                        Icons.pets_rounded,
                        color: Colors.white,
                      ),
                    ),
                    Transform.rotate(
                      angle: -30 * 3.14 / 180,
                      child: Icon(
                        Icons.pets_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ]),
                ],
              ),

              actions: state.user != null
                  ? [
                      IconButton(
                        icon: Icon(Icons.favorite),
                        color: Colors.white,
                        iconSize: 33,
                        onPressed: () =>
                            Navigator.pushNamed(context, '/favorite'),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Badge(
                            position: BadgePosition.topEnd(top: 8, end: 8),
                            badgeContent: state.cartProducts.length > 0
                                ? Text(state.cartProducts.length.toString(),
                                    style: TextStyle(color: Colors.white))
                                : null,
                            badgeColor: Colors.blueGrey,
                            child: IconButton(
                              icon: Icon(Icons.shopping_cart),
                              iconSize: 33,
                              color: state.cartProducts.length == 0
                                  ? Colors.white
                                  : Colors.blueGrey,
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/cart'),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(Icons.search),
                      ),
                      //Icon(Icons.more_vert),
                    ]
                  :
                  // incase user is not login
                  [
                      Padding(
                        padding: EdgeInsets.only(right: 40.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            "Sign in",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      )
                    ],
              backgroundColor: Theme.of(context).primaryColor,
            );
          }));
}
