import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/pages/product/product_detail_page.dart';
import 'package:pawpoint/redux/actions/actions.dart';
import 'package:pawpoint/redux/actions/fav_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';

class ProductItem extends StatelessWidget {
  final Product item;
  ProductItem({this.item});

  bool _isInCart(AppState state, int id) {
    final List<Product> cartProducts = state.cartProducts;
    return cartProducts.indexWhere((cartProduct) => cartProduct.id == id) > -1;
  }

  bool _isInFav(AppState state, int id) {
    final List<Product> favProducts = state.favProducts;
    return favProducts.indexWhere((favProduct) => favProduct.id == id) > -1;
  }

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = db_url + '${item.picture}';
    String wieght_text = '';
    bool t = true;

    if (item.weight != 0 && item.service != "service") {
      wieght_text = '${item.weight.toString()} KG';
    }

    // to be able to Tap
    return t == false
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: h(20),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: myiamge(pictureUrl),
                            ),
                            _fav_ico(context, _isInFav, item)
                          ],
                        )),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: Colors.grey,
                        ),
                        child: Column(
                          children: [
                            FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${item.name}',
                                      style: TextStyle(fontSize: 20.0)),
                                )),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('${item.price} EGP',
                                              style: TextStyle(fontSize: 20.0)),
                                        )),
                                  ),
                                  StoreConnector<AppState, AppState>(
                                      converter: (store) => store.state,
                                      builder: (_, state) {
                                        return item.service == "service"
                                            ? IconButton(
                                                icon: Icon(Icons.contact_phone),
                                                iconSize: 30,
                                                color: Colors.green,
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/contactus');
                                                  // go to contact page
                                                })
                                            : IconButton(
                                                icon: Icon(Icons.shopping_cart),
                                                iconSize: 30,
                                                color: _isInCart(state, item.id)
                                                    ? Colors.white
                                                    : Color(0xffe83636),
                                                onPressed: () {
                                                  if (state.user == null) {
                                                    Navigator.pushNamed(
                                                        context, '/login');
                                                    StoreProvider.of<AppState>(
                                                            context)
                                                        .dispatch(
                                                            toggleCartProductAction(
                                                                item));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: const Text(
                                                                'Please login First')));
                                                  } else {
                                                    StoreProvider.of<AppState>(
                                                            context)
                                                        .dispatch(
                                                            toggleCartProductAction(
                                                                item));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: const Text(
                                                                'Cart updated')));
                                                  }
                                                });
                                      })
                                ])
                          ],
                        ),
                      ),
                    
                  ],
                )),
          )
        : 
        // Material(
        //     type: MaterialType.transparency,
        //     child:
             Container(
              // margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
              // height: double.infinity,
              // width: double.infinity,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(20),
              //   color: Colors.white,
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.black.withOpacity(0.5),
              //       spreadRadius: 5,
              //       blurRadius: 7,
              //       offset: Offset(0, 3), // changes position of shadow
              //     ),
              //   ],
              // ),
              child: Container(
                // borderRadius: BorderRadius.circular(0.0),
                child: InkWell(
                  //borderRadius: BorderRadius.circular(20),
                  onTap: () => Navigator.of(context).push(
                      // to call product detailpage from this page and forward item
                      MaterialPageRoute(builder: (context) {
                    return ProductDetailPage(item: item);
                  })),
                  child: GridTile(
                    header: Align(
                        alignment: Alignment.centerRight,
                        child: _fav_ico(context, _isInFav, item)),
                    footer:Container(),
                    // for fine transition from big to large
                    child:Column(
                      children:[
                        Container(
                      alignment: Alignment.topLeft,
                      child: Hero(
                        // should have the same tag
                        tag: item,
                        child: Container(
                              height: h(18),
                              width:w(40),
                              //color: Colors.yellow,
                              child: myiamge(pictureUrl),
                            )
                      )),
                          Container(
    // height: h(9),
              // margin: EdgeInsets.only(top:h(2),left: w(3), bottom: h(1.5), right: w(3)),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Color(0xff504E4E),
              border: Border.all(width: 1.0, color: const Color(0xffd8d8d8)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(-10, -10),
                  blurRadius: 6,
                ),
              ]),
    child:GridTileBar(
                      title: Text(
                        '${item.name}',
                        // overflow: TextOverflow.ellipsis,
                      ),
                      trailing: StoreConnector<AppState, AppState>(
                          converter: (store) => store.state,
                          builder: (_, state) {
                            return item.service == "service"
                                ? IconButton(
                                    icon: Icon(Icons.contact_phone),
                                    iconSize: 30,
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/contactus');
                                      // go to contact page
                                    })
                                : IconButton(
                                    icon: Icon(Icons.shopping_cart),
                                    iconSize: 30,
                                    color: _isInCart(state, item.id)
                                        ? Color(0xffe83636)
                                        : Colors.white,
                                    onPressed: () {
                                      if (state.user == null) {
                                        Navigator.pushNamed(context, '/login');
                                        StoreProvider.of<AppState>(context)
                                            .dispatch(
                                                toggleCartProductAction(item));
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: const Text(
                                                    'Please login First')));
                                      } else {
                                        StoreProvider.of<AppState>(context)
                                            .dispatch(
                                                toggleCartProductAction(item));
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: const Text(
                                                    'Cart updated')));
                                      }
                                    });
                          }),
                      subtitle: Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text('${item.price} EGP',
                                  style: TextStyle(fontSize: 20.0,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700)
                                  ),
                            ),
                          ]),

                      //  FittedBox(
                      //     fit: BoxFit.scaleDown,
                      //     alignment: Alignment.centerLeft,
                      //     child: Text('${item.name}',
                      //         style: TextStyle(fontSize: 20.0))),
                      // subtitle: Text(
                      //   '${item.price} EGP ',
                      //   style: TextStyle(fontSize: 16.0, color: Color(0xffe83636)),
                      // ),
                      // backgroundColor: Color(0xBB000000),
                      // trailing:

                      // StoreConnector<AppState, AppState>(
                      //   converter: (store) => store.state,
                      //   builder: (_, state) {
                      //     return item.service == "service"
                      //         ? IconButton(
                      //             icon: Icon(Icons.contact_phone),
                      //             iconSize: 30,
                      //             color: Colors.green,
                      //             onPressed: () {
                      //               Navigator.pushNamed(context, '/contactus');
                      //               // go to contact page
                      //             })
                      //         : IconButton(
                      //             icon: Icon(Icons.shopping_cart),
                      //             iconSize: 30,
                      //             color: _isInCart(state, item.id)
                      //                 ? Colors.orange
                      //                 : Colors.white,
                      //             onPressed: () {
                      //               if (state.user == null) {
                      //                 Navigator.pushNamed(context, '/login');
                      //                 StoreProvider.of<AppState>(context)
                      //                     .dispatch(
                      //                         toggleCartProductAction(item));
                      //                 ScaffoldMessenger.of(context)
                      //                     .hideCurrentSnackBar();
                      //                 ScaffoldMessenger.of(context)
                      //                     .showSnackBar(SnackBar(
                      //                         content: const Text(
                      //                             'Please login First')));
                      //               } else {
                      //                 StoreProvider.of<AppState>(context)
                      //                     .dispatch(
                      //                         toggleCartProductAction(item));
                      //                 ScaffoldMessenger.of(context)
                      //                     .hideCurrentSnackBar();
                      //                 ScaffoldMessenger.of(context)
                      //                     .showSnackBar(SnackBar(
                      //                         content:
                      //                             const Text('Cart updated')));
                      //               }
                      //             });
                      //   },
                      // ),
                    ),
                        
                    )] ),
                    ),
                    
                  ),
                ),
              
            // ),
          );
  }
}

// to show circular progress bar during loading
Widget myiamge(pictureUrl) {
  return (
    Image.network(
    pictureUrl,
    // fit: BoxFit.fill,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes
              : null,
        ),
      );
    },
  ));
}

Widget _fav_ico(context, _isInFav, item) {
  return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return IconButton(
            icon: Icon(
              _isInFav(state, item.id) ? Icons.favorite : Icons.favorite_border,
              size: 30,
            ),
            color: _isInFav(state, item.id) ? Color(0xffe83636) : Colors.grey,
            onPressed: () {
              if (state.user == null) {
                Navigator.pushNamed(context, '/login');
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please Login Fist")),
                );
              } else {
                StoreProvider.of<AppState>(context)
                    .dispatch(toggleFavProductAction(item));
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: _isInFav(state, item.id)
                        ? Text("Removed from Favorite")
                        : Text('Added to Favorite'),
                  ),
                );
              }
            });
      });
}
