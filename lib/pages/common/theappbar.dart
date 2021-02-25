import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

Widget theappBar(context, titlename) {
  return PreferredSize(
      // to increase appbar size
      preferredSize: Size.fromHeight(h(8)),
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return AppBar(
              //leading: Icon(Icons.menu),

              title: Row(
                children: [
                  Text(
                    titlename,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),

              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/cart'),
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
                        onPressed: () => Navigator.pushNamed(context, '/cart'),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  iconSize: 33,
                  color: Colors.white,
                  onPressed: () => Navigator.pushNamed(context, '/search',
                      arguments: {'senttext': ''}),
                ),
              ],
              // actions: state.user != null
              //     ? [
              //         IconButton(
              //           icon: Icon(Icons.favorite),
              //           iconSize: 33,
              //           color: Colors.white,
              //           onPressed: () =>
              //               Navigator.pushNamed(context, '/favorite'),
              //         ),
              //         Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 16),
              //             child: GestureDetector(
              //               onTap: () => Navigator.pushNamed(context, '/cart'),
              //               child: Badge(
              //                 position: BadgePosition.topEnd(top: 8, end: 8),
              //                 badgeContent: state.cartProducts.length > 0
              //                     ? Text(state.cartProducts.length.toString(),
              //                         style: TextStyle(color: Colors.white))
              //                     : null,
              //                 badgeColor: Colors.blueGrey,
              //                 child: IconButton(
              //                   icon: Icon(Icons.shopping_cart),
              //                   iconSize: 33,
              //                   color: state.cartProducts.length == 0
              //                       ? Colors.white
              //                       : Colors.orange,
              //                   onPressed: () =>
              //                       Navigator.pushNamed(context, '/cart'),
              //                 ),
              //               ),
              //             )),
              //         Padding(
              //           padding: EdgeInsets.symmetric(horizontal: 16),
              //           child: IconButton(
              //             icon: Icon(Icons.search),
              //             iconSize: 33,
              //             color: Colors.white,
              //             onPressed: () =>
              //                 Navigator.pushNamed(context, '/search'),
              //           ),
              //         ),
              //         //Icon(Icons.more_vert),
              //       ]
              //     :
              //     // incase user is not login
              //     [
              //         Padding(
              //           padding: EdgeInsets.only(right: 40.0),
              //           child: TextButton(
              //             onPressed: () {
              //               Navigator.pushNamed(context, '/login');
              //             },
              //             child: Text(
              //               "Sign in",
              //               style:
              //                   TextStyle(color: Colors.orange, fontSize: 20),
              //             ),
              //           ),
              //         )
              //       ],
              backgroundColor: Theme.of(context).primaryColor,
            );
          }));
}
