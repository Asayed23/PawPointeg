import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/redux/actions/actions.dart';
import 'package:pawpoint/redux/actions/fav_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';

class Thedrawer extends StatefulWidget {
  @override
  _ThedrawerState createState() => _ThedrawerState();
}

class _ThedrawerState extends State<Thedrawer> {
  Product _filterProduct = Product();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Center(
                      child: state.user != null
                          ? Column(children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () =>
                                      //Navigator.pushNamed(context, ProfileScreen.routeName),
                                      Navigator.pushNamed(context, '/profile')),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/profile'),
                                child: Text('Hi ' + state.user.username,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                            ])
                          : TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/pet-grooming.svg",
                      width: 38,
                      height: 38,
                    ),
                    title: Text('Service'),
                    onTap: () {
                      _filterProduct.pet = 'outoffilter';
                      _filterProduct.category = 'outoffilter';
                      _filterProduct.bestSelling = false;
                      _filterProduct.limitedOffer = false;
                      _filterProduct.service = 'service';
                      _filterProduct.subCategory = 'outoffilter';
                      Navigator.pushNamed(context, '/products',
                          arguments: {'thetarget': _filterProduct.toJson()});
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/pet-hotel-signal.svg",
                      width: 38,
                      height: 38,
                    ), // Image.asset('assets/icons/dog.svg'),
                    title: Text('Dog'),
                    onTap: () {
                      _filterProduct.pet = 'Dog';
                      _filterProduct.category = 'outoffilter';
                      _filterProduct.bestSelling = false;
                      _filterProduct.limitedOffer = false;
                      _filterProduct.service = 'product';
                      _filterProduct.subCategory = 'outoffilter';
                      Navigator.pushNamed(context, '/products',
                          arguments: {'thetarget': _filterProduct.toJson()});
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/cat (1).svg",
                      width: 38,
                      height: 38,
                    ), // Image.asset('assets/icons/dog.svg'),
                    title: Text('cat'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      _filterProduct.pet = 'Cat';
                      _filterProduct.category = 'outoffilter';
                      _filterProduct.bestSelling = false;
                      _filterProduct.limitedOffer = false;
                      _filterProduct.service = 'product';
                      _filterProduct.subCategory = 'outoffilter';
                      Navigator.pushNamed(context, '/products',
                          arguments: {'thetarget': _filterProduct.toJson()});
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/like.svg",
                      width: 30,
                      height: 30,
                    ), // Image.asset('assets/icons/dog.svg'),
                    title: Text('Best Selling'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      _filterProduct.pet = 'outoffilter';
                      _filterProduct.category = 'Best Selling';
                      _filterProduct.bestSelling = true;
                      _filterProduct.limitedOffer = false;
                      _filterProduct.service = 'outoffilter';
                      _filterProduct.subCategory = 'outoffilter';
                      Navigator.pushNamed(context, '/products',
                          arguments: {'thetarget': _filterProduct.toJson()});
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/contacts.svg",
                      width: 30,
                      height: 30,
                    ), // Image.asset('assets/icons/dog.svg'),
                    title: Text('Contact us'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pushNamed(
                        context,
                        '/contactus',
                      );
                    },
                  ),
                  state.user != null
                      ? ListTile(
                          title: Text('Log out'),
                          leading: Icon(Icons.exit_to_app),
                          onTap: () {
                            StoreProvider.of<AppState>(context)
                                .dispatch(logoutUserAction);
                            StoreProvider.of<AppState>(context)
                                .dispatch(getCartProductsAction);
                            StoreProvider.of<AppState>(context)
                                .dispatch(getfavProductsAction);
                            Navigator.pushReplacementNamed(context, '/home');
                          })
                      : Text(''),
                ],
              ),
            );
          }),
    );
  }
}
