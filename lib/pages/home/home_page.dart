import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/models/enums.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/models/user.dart';
import 'package:pawpoint/pages/common/bottombar.dart';
import 'package:pawpoint/pages/common/theappbar.dart';
import 'package:pawpoint/pages/common/thedrawer.dart';
import 'package:pawpoint/pages/product/product_widgets/product_item.dart';
import 'package:pawpoint/pages/product/products_page.dart';
import 'package:pawpoint/pages/home/home_widgets/home_appbar.dart';
import 'package:pawpoint/redux/actions/actions.dart';
import 'package:pawpoint/redux/actions/add_action.dart';
import 'package:pawpoint/redux/actions/category_action.dart';
import 'package:pawpoint/redux/actions/fav_action.dart';
import 'package:pawpoint/redux/actions/order_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

class HomePage extends StatefulWidget {
  final void Function() onInit;
  HomePage({this.onInit});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    widget.onInit();
  }

  Product _filterProduct = Product();
  Future<void> _pullRefresh() async {
    StoreProvider.of<AppState>(context).dispatch(getUserAction);
    StoreProvider.of<AppState>(context).dispatch(getProductsAction);
    StoreProvider.of<AppState>(context).dispatch(getCartProductsAction);
    StoreProvider.of<AppState>(context).dispatch(getfavProductsAction);
    StoreProvider.of<AppState>(context).dispatch(getaddressAction);
    StoreProvider.of<AppState>(context).dispatch(getHistoryOrder);
    // //getcartItemsAction
    // StoreProvider.of<AppState>(context)
    //     .dispatch(getcartItemsAction);
    StoreProvider.of<AppState>(context).dispatch(catProdAction);
    StoreProvider.of<AppState>(context).dispatch(dogProdAction);
    StoreProvider.of<AppState>(context).dispatch(servProdAction);
    StoreProvider.of<AppState>(context).dispatch(bestSellAction);
    return;
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        User _user = state.user;

        return WillPopScope(
          //onWillPop: _onWillPop,
          onWillPop: () async => false,
          child: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: homeappbar(context, 'Paw Point', state),
              drawer: Thedrawer(),
              bottomNavigationBar:
                  CustomBottomNavBar(selectedMenu: MenuState.home),
              body: state.inloading.allproduct &&
                      state.inloading.bestproduct &&
                      state.inloading.catproduct &&
                      state.inloading.dogproduct &&
                      state.inloading.bestproduct &&
                      state.inloading.servproduct
                  ? Container(
                      child: Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).accentColor)),
                    ))
                  : new ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        new SizedBox(height: 20.0),
                        new Container(
                          child: new ListView.builder(
                            shrinkWrap: true,
                            itemCount: 1,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return new Column(
                                children: <Widget>[
                                  _maincategory(context, _filterProduct),
                                  Divider(),
                                  //_header('Service'),
                                  GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        _filterProduct.pet = 'outoffilter';
                                        _filterProduct.category = 'outoffilter';
                                        _filterProduct.bestSelling = false;
                                        _filterProduct.limitedOffer = false;
                                        _filterProduct.service = 'service';
                                        _filterProduct.subCategory =
                                            'outoffilter';
                                        Navigator.pushNamed(
                                            context, '/products', arguments: {
                                          'thetarget': _filterProduct.toJson()
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.asset(
                                                'assets/images/service.png')),
                                      )),
                                  // _horizontalListView(state.serviceProducts,'service', _filterProduct),
                                  new SizedBox(height: h(1)),
                                  Divider(),
                                  _header('Cat'),
                                  _horizontalListView(
                                      state.catProducts, 'Cat', _filterProduct),
                                  new SizedBox(height: h(1)),
                                  Divider(),
                                  _header('Dog'),
                                  _horizontalListView(
                                      state.dogProducts, 'Dog', _filterProduct),
                                  new SizedBox(height: h(1)),
                                  Divider(),
                                  _header('Best Selling'),
                                  _horizontalListView(state.bestSellingProducts,
                                      'bestSelling', _filterProduct),
                                  new SizedBox(height: h(1)),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    ));
  }
}

Widget _horizontalListView(products, target, _filterProduct) {
  int cont = products.length < 8 ? products.length : 7;
  return new Container(
    height: h(30),
    child: new ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: cont,
      itemBuilder: (context, index) {
        return new Card(
          elevation: 0.0,
          child: new Container(
              height: MediaQuery.of(context).size.width / 5,
              width: MediaQuery.of(context).size.width / 2,
              alignment: Alignment.center,
              child: index < cont - 1
                  ? ProductItem(item: products[index])
                  : FlatButton(
                      textColor: Color(0xffe83636),
                      autofocus: true,
                      onPressed: () {
                        _filterProduct.pet = target;
                        _filterProduct.category = 'All';
                        target == 'bestSelling'
                            ? _filterProduct.bestSelling = false
                            : _filterProduct.bestSelling = true;
                        _filterProduct.limitedOffer = false;
                        target == 'service'
                            ? _filterProduct.service = 'service'
                            : _filterProduct.service = 'product';
                        _filterProduct.subCategory = 'outoffilter';
                        Navigator.pushNamed(context, '/products',
                            arguments: {'thetarget': _filterProduct.toJson()});
                      },
                      child: Text(
                        "Show More",
                      ),
                    )),
        );
      },
    ),
  );
}

Widget _maincategory(context, _filterProduct) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    OutlineButton(
        child: Text("Dog"),
        borderSide: BorderSide(color: Colors.black),
        shape: StadiumBorder(),
        // icon: SvgPicture.asset(
        //   "assets/icons/pet-hotel-signal.svg",
        //   width: 38,
        //   height: 38,
        // ),
        onPressed: () {
          _filterProduct.pet = "Dog";
          _filterProduct.category = 'All';
          _filterProduct.bestSelling = false;
          _filterProduct.limitedOffer = false;
          _filterProduct.service = 'product';
          _filterProduct.subCategory = 'outoffilter';

          Navigator.pushNamed(context, '/products',
              arguments: {'thetarget': _filterProduct.toJson()});
        } //do something,
        ),
    OutlineButton(
        child: Text("Cat"),
        borderSide: BorderSide(color: Colors.black),
        shape: StadiumBorder(),
        // icon: SvgPicture.asset(
        //   "assets/icons/pet-hotel-signal.svg",
        //   width: 38,
        //   height: 38,
        // ),
        onPressed: () {
          _filterProduct.pet = "Cat";
          _filterProduct.category = 'All';
          _filterProduct.bestSelling = false;
          _filterProduct.limitedOffer = false;
          _filterProduct.service = 'product';
          _filterProduct.subCategory = 'outoffilter';
          Navigator.pushNamed(context, '/products',
              arguments: {'thetarget': _filterProduct.toJson()});
        } //do something,
        ),
    OutlineButton(
        child: Text("Service"),
        borderSide: BorderSide(color: Colors.black),
        shape: StadiumBorder(),
        // icon: SvgPicture.asset(
        //   "assets/icons/pet-hotel-signal.svg",
        //   width: 38,
        //   height: 38,
        // ),
        onPressed: () {
          _filterProduct.pet = 'outoffilter';
          _filterProduct.category = 'outoffilter';
          _filterProduct.bestSelling = false;
          _filterProduct.limitedOffer = false;
          _filterProduct.service = 'service';
          _filterProduct.subCategory = 'outoffilter';
          Navigator.pushNamed(context, '/products',
              arguments: {'thetarget': _filterProduct.toJson()});
        } //do something,
        ),
  ]);
}

Widget _header(str) {
  return Container(
    
      child: Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left:24),
      child: Text(str,
          style: new TextStyle(
              fontSize: 18.0,
              color: Color(0xffe83636),
              fontWeight: FontWeight.bold)),
    ),
  ));
}
