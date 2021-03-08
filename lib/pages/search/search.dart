import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:pawpoint/pages/product/product_widgets/product_item.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:pawpoint/size_config.dart';
import 'package:pawpoint/redux/actions/category_action.dart';

class SearchPage extends StatefulWidget {
  final String senttext;
  SearchPage({this.senttext});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _filter = new TextEditingController();
  bool isSearching = false;
  String _search_text;
  List<Product> productss = [];
  List<Product> filteredproducts = [];

  // Future<void> _filterProducts(value) async {
  //   http.Response response =
  //       await http.post(product_url, body: {'key_word': value});
  //   final List<dynamic> responseData = json.decode(response.body);
  //   List<Product> products = [];

  //   responseData.forEach((productData) {
  //     final Product product = Product.fromJson(productData);
  //     products.add(product);
  //   });

  //   filteredproducts = products;
  // }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          final Map arguments =
              ModalRoute.of(context).settings.arguments as Map;
          if (arguments != null) {
            _search_text = arguments['senttext'];
            filteredproducts = searchproduct(state.products, _search_text);
          }

          return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.black, //change your color here
                ),
                backgroundColor: Colors.white,
                title: Container(
                  height: h(7),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    controller: _filter,
                    onSubmitted: (value) {
                      _search_text = value;
                      Navigator.popAndPushNamed(context, '/search',
                          arguments: {'senttext': value});
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        fillColor: Colors.grey[300],
                        filled: true,
                        hintText: _search_text != null && _search_text != ''
                            ? _search_text
                            : "Search.....",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        )),
                  ),
                ),
              ),
              body: arguments == null
                  ? Container(
                      child: Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).accentColor)),
                    ))
                  : _search_text == ''
                      ? Center(child: Text('please Enter Key words'))
                      : filteredproducts.length == 0 && arguments != null
                          ? Container(
                              child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Center(
                                      child: RichText(
                                          text: TextSpan(
                                    text:
                                        "Unfortunately, No Products or Services are matching  ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '$_search_text',
                                          style: TextStyle(
                                              color: Color(0xffe83636))),
                                    ],
                                  )))))
                          : Column(children: [
                              Expanded(
                                child: SafeArea(
                                  top: false,
                                  bottom: false,
                                  child: GridView.builder(
                                    itemCount: filteredproducts.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                SizeConfig.devicetype ==
                                                        DeviceType.Mobile
                                                    ? 2
                                                    : 3,
                                            crossAxisSpacing: w(1),
                                            mainAxisSpacing: h(1),
                                            childAspectRatio: ((w(100) / 2)) /
                                                (h(100) / 2.9)),
                                    itemBuilder: (context, i) {
                                      if (i < filteredproducts.length) {
                                        return ProductItem(
                                            item: filteredproducts[i]);
                                      } else {
                                        return LoadingBouncingGrid.circle();
                                      }
                                    },
                                  ),
                                ),
                              )
                            ]));
        });
  }
}
