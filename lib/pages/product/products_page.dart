import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:pawpoint/models/enums.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/pages/common/bottombar.dart';
import 'package:pawpoint/pages/common/theappbar.dart';
import 'package:pawpoint/pages/common/thedrawer.dart';
import 'package:pawpoint/pages/product/product_widgets/product_appbar.dart';
import 'package:pawpoint/pages/product/product_widgets/product_bottombar.dart';
import 'package:pawpoint/pages/product/product_widgets/product_item.dart';
import 'package:pawpoint/pages/testpage/test_page.dart';
import 'package:pawpoint/redux/actions/actions.dart';
import 'package:pawpoint/redux/actions/category_action.dart';
import 'package:pawpoint/redux/actions/order_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

final gradientBackground = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        stops: [
      0.1,
      0.3,
      0.5,
      0.7,
      0.9
    ],
        colors: [
      Colors.deepOrange[300],
      Colors.deepOrange[400],
      Colors.deepOrange[500],
      Colors.deepOrange[600],
      Colors.deepOrange[700]
    ]));

class ProductsPage extends StatefulWidget {
  final void Function() onInit;
  bool isSearching = false;
  Map<String, dynamic> thetarget;

  ProductsPage({this.onInit, this.thetarget});

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  // used variables
  List<Product> _cureentProducts;
  List<Product> _allfilterproducts;
  List<String> _listofcategory;
  List<String> _listofsubCategory;
  String _titlename;
  int initalindex;
  Product _filterProduct = Product();
  final scrollController = ScrollController();

  // Inital state
  void initState() {
    _titlename = '';

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (_allfilterproducts != null) {
          _cureentProducts =
              loadmoreimages(_allfilterproducts, _cureentProducts);
          StoreProvider.of<AppState>(context)
              .dispatch(UpdateShowProduct(_cureentProducts));
        }

        //return state.products;
      }
    });

    super.initState();
    widget.onInit();
  }

  Widget _horizontalListView(state) {
    return DefaultTabController(
        length: _listofcategory.length + 1, // length of tabs
        initialIndex: _listofcategory.indexWhere((categ) =>
                    categ.startsWith(widget.thetarget['category'])) !=
                -1
            ? _listofcategory.indexWhere(
                    (categ) => categ.startsWith(widget.thetarget['category'])) +
                1
            : 0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  child: TabBar(
                      labelColor: Colors.red,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      tabs: List<Widget>.generate(_listofcategory.length + 1,
                          (int index) {
                        return index == 0
                            ? GestureDetector(
                                onTap: () {
                                  _filterProduct.pet = widget.thetarget['pet'];
                                  _filterProduct.category = 'All';
                                  _filterProduct.service =
                                      widget.thetarget['service'];
                                  //_filterProduct.subCategory = 'outoffilter';
                                  _filterProduct.subCategory = 'outoffilter';
                                  _filterProduct.bestSelling = false;
                                  _filterProduct.limitedOffer = false;
                                  print(_filterProduct.toJson());
                                  StoreProvider.of<AppState>(context)
                                      .dispatch(UpdateShowProduct(null));

                                  Navigator.popAndPushNamed(
                                      context, '/products', arguments: {
                                    'thetarget': _filterProduct.toJson()
                                  });
                                },
                                child: Tab(text: "All"))
                            : GestureDetector(
                                onTap: () {
                                  _filterProduct.pet = widget.thetarget['pet'];
                                  _filterProduct.category =
                                      _listofcategory[index - 1];
                                  _filterProduct.bestSelling = false;
                                  _filterProduct.service =
                                      widget.thetarget['service'];
                                  _filterProduct.subCategory = 'outoffilter';
                                  print(_filterProduct.toJson());
                                  StoreProvider.of<AppState>(context)
                                      .dispatch(UpdateShowProduct(null));
                                  Navigator.popAndPushNamed(
                                      context, '/products', arguments: {
                                    'thetarget': _filterProduct.toJson()
                                  });
                                },
                                child: Tab(text: _listofcategory[index - 1]));
                      })))
            ]));
  }

  Widget _horizontaSubCategory(state) {
    return new Container(
      height: h(7),
      child: new ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _listofsubCategory.length + 1,
        itemBuilder: (context, index) {
          return index == 0
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _filterProduct.pet = widget.thetarget['pet'];
                    _filterProduct.category = widget.thetarget['category'];
                    _filterProduct.service = widget.thetarget['service'];
                    _filterProduct.subCategory = 'All';
                    _filterProduct.bestSelling = false;
                    _filterProduct.limitedOffer = false;
                    print(_filterProduct.toJson());
                    StoreProvider.of<AppState>(context)
                        .dispatch(UpdateShowProduct(null));

                    Navigator.popAndPushNamed(context, '/products',
                        arguments: {'thetarget': _filterProduct.toJson()});
                  }, //do something
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        //right: BorderSide(width: 2.0, color: Colors.grey),
                        bottom: BorderSide(
                            width: 4.0,
                            color: widget.thetarget['subCategory'] == 'All' ||
                                    widget.thetarget['subCategory'] ==
                                        'outoffilter'
                                ? Color(0xffe83636)
                                : Colors.grey),
                      ),
                    ),
                    child: Text(
                      "All",
                      style: TextStyle(
                          color: widget.thetarget['subCategory'] == 'All' ||
                                  widget.thetarget['subCategory'] ==
                                      'outoffilter'
                              ? Color(0xffe83636)
                              : Colors.grey),
                    ),
                  ))

              // OutlineButton(
              //     child: Text(
              //       "All",
              //       style: TextStyle(
              //           color: widget.thetarget['subCategory'] == 'All'
              //               ? Color(0xffe83636)
              //               : Colors.blue),
              //     ),

              //     borderSide: BorderSide(
              //         color: widget.thetarget['subCategory'] == 'All'
              //             ? Color(0xffe83636)
              //             : Colors.blue),
              //     shape: StadiumBorder(),
              //     onPressed: () {
              //       _filterProduct.pet = widget.thetarget['pet'];
              //       _filterProduct.category = widget.thetarget['category'];
              //       _filterProduct.service = widget.thetarget['service'];
              //       _filterProduct.subCategory = 'All';
              //       _filterProduct.bestSelling = false;
              //       _filterProduct.limitedOffer = false;
              //       print(_filterProduct.toJson());
              //       StoreProvider.of<AppState>(context)
              //           .dispatch(UpdateShowProduct(null));

              //       Navigator.popAndPushNamed(context, '/products',
              //           arguments: {'thetarget': _filterProduct.toJson()});
              //     } //do something,
              //     )
              : GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _filterProduct.pet = widget.thetarget['pet'];
                    _filterProduct.category = widget.thetarget['category'];
                    _filterProduct.bestSelling = false;
                    _filterProduct.service = widget.thetarget['service'];
                    _filterProduct.subCategory = _listofsubCategory[index - 1];
                    print(_filterProduct.toJson());
                    StoreProvider.of<AppState>(context)
                        .dispatch(UpdateShowProduct(null));
                    Navigator.popAndPushNamed(context, '/products',
                        arguments: {'thetarget': _filterProduct.toJson()});
                  }, //do something
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                          width: 4.0,
                          color: widget.thetarget['subCategory'] ==
                                  _listofsubCategory[index - 1]
                              ? Color(0xffe83636)
                              : Colors.grey),
                    )),
                    child: Text(
                      _listofsubCategory[index - 1],
                      style: TextStyle(
                          color: widget.thetarget['subCategory'] ==
                                  _listofsubCategory[index - 1]
                              ? Color(0xffe83636)
                              : Colors.grey),
                    ),
                  ));

          // OutlineButton(
          //     child: Text(
          //       _listofsubCategory[index - 1],
          //       style: TextStyle(
          //           color: widget.thetarget['subCategory'] ==
          //                   _listofsubCategory[index - 1]
          //               ? Color(0xffe83636)
          //               : Colors.blue),
          //     ),
          //     borderSide: BorderSide(
          //         color: widget.thetarget['subCategory'] ==
          //                 _listofsubCategory[index - 1]
          //             ? Color(0xffe83636)
          //             : Colors.blue),
          //     //highlightColor: Color(0xffe83636),
          //     shape: StadiumBorder(),
          //     // icon: SvgPicture.asset(
          //     //   "assets/icons/pet-hotel-signal.svg",
          //     //   width: 38,
          //     //   height: 38,
          //     // ),
          //     onPressed: () {
          //       _filterProduct.pet = widget.thetarget['pet'];
          //       _filterProduct.category = widget.thetarget['category'];
          //       _filterProduct.bestSelling = false;
          //       _filterProduct.service = widget.thetarget['service'];
          //       _filterProduct.subCategory = _listofsubCategory[index - 1];
          //       print(_filterProduct.toJson());
          //       StoreProvider.of<AppState>(context)
          //           .dispatch(UpdateShowProduct(null));
          //       Navigator.popAndPushNamed(context, '/products',
          //           arguments: {'thetarget': _filterProduct.toJson()});
          //     } //do something,
          //     )
        },
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  bool typing = false;
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    widget.thetarget = arguments['thetarget'];

    _allfilterproducts = filterImage(
        StoreProvider.of<AppState>(context).state.products,
        widget.thetarget['pet'],
        widget.thetarget['service'],
        widget.thetarget['category'],
        widget.thetarget['best_selling'],
        widget.thetarget['limited_offer'],
        widget.thetarget['subCategory']);
    widget.thetarget['category'] == 'outoffilter'
        ? _titlename = widget.thetarget['pet']
        : _titlename = widget.thetarget['category'];
    if (widget.thetarget['service'] == 'service') _titlename = 'Services';

    if (_allfilterproducts != null) {
      _cureentProducts = loadmoreimages(_allfilterproducts, _cureentProducts);
      StoreProvider.of<AppState>(context)
          .dispatch(UpdateShowProduct(_cureentProducts));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: theappBar(context, _titlename),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.notselected),
      body: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (_, state) {
            // List of Category
            _listofcategory = [];
            _listofsubCategory = [];
            state.products.forEach((productData) {
              if (productData.toJson()['pet'] == widget.thetarget['pet'] &&
                  productData.toJson()['service'] == 'product') {
                final String product = productData.toJson()['category'];
                _listofcategory.add(product);
                _listofsubCategory.add(productData.toJson()['subCategory']);
              }
            });
            _listofcategory = _listofcategory.toSet().toList();
            _listofcategory.removeWhere((value) => value == null);
            // Sub List of Cateogry
            _listofsubCategory = [];
            if (widget.thetarget['category'] != 'outoffilter') {
              state.products.forEach((productData) {
                if (productData.toJson()['pet'] == widget.thetarget['pet'] &&
                    productData.toJson()['service'] == 'product' &&
                    productData.toJson()['category'] ==
                        widget.thetarget['category']) {
                  _listofsubCategory.add(productData.toJson()['subCategory']);
                }
              });
              _listofsubCategory = _listofsubCategory.toSet().toList();
              _listofsubCategory.removeWhere((value) => value == null);
            }
            print(_listofsubCategory);

            return state.serviceProducts == null
                ? Container(
                    child: Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).accentColor)),
                  ))
                : GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (_allfilterproducts != null) {
                        _cureentProducts = loadmoreimages(
                            _allfilterproducts, _cureentProducts);
                        StoreProvider.of<AppState>(context)
                            .dispatch(UpdateShowProduct(_cureentProducts));
                      }
                    },
                    child: Container(
                        child: Column(children: [
                      //_maincategory(context),
                      SizedBox(height: h(1)),

                      widget.thetarget['service'] == 'product'
                          ? _horizontalListView(state)
                          : Text(''),
                      SizedBox(height: h(1)),
                      if (_listofsubCategory.length > 1)
                        _horizontaSubCategory(state),
                      Divider(),
                      Expanded(
                        child: SafeArea(
                          top: false,
                          bottom: false,
                          child: GridView.builder(
                            controller: scrollController,
                            itemCount:
                                state.serviceProducts.length + 1.compareTo(0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        SizeConfig
                                                    .devicetype ==
                                                DeviceType.Mobile
                                            ? 2
                                            : 3,
                                    crossAxisSpacing: w(1),
                                    mainAxisSpacing: h(1),
                                    childAspectRatio:
                                        ((w(100) / 2)) / (h(100) / 2.9)),
                            itemBuilder: (context, i) {
                              if (i < state.serviceProducts.length) {
                                return ProductItem(
                                    item: state.serviceProducts[i]);
                              } else if (state.serviceProducts.length <
                                  _allfilterproducts.length) {
                                return LoadingBouncingGrid.circle();
                              } else {
                                return Container(
                                    child: Center(
                                        child: Text(
                                            'No more things can be shown')));
                              }
                            },
                          ),
                        ),
                      )
                    ])),
                  );
          }
          // bottomNavigationBar: productbottombar(context),
          ),
    );
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      // color: Colors.white,
      child: TextField(
        decoration: InputDecoration(hintText: 'Search'),
      ),
    );
  }
}
