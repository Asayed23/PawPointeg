import 'dart:convert';
import 'package:pawpoint/db_links/db_links.dart';
import 'package:pawpoint/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:pawpoint/redux/actions/inloading_action.dart';
import 'package:pawpoint/redux/reducers/reducers.dart';
import 'package:pawpoint/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

/* get total price */
// ThunkAction<AppState> getordertotalprice = (Store<AppState> store) async {
//   final List<Product> cartProducts = store.state.cartProducts;
//   final User user = store.state.user;
//   double ordertotalprice = 20;
//   store.dispatch(Getordertotalprice(ordertotalprice));
// };

ThunkAction<AppState> bestSellAction = (Store<AppState> store) async {
  // http.Response response = await http.get(bestsell_url);

  // final List<dynamic> responseData = json.decode(response.body);

  List<Product> _allproducts = store.state.products;
  List<Product> _filterproduct = [];
  _allproducts.forEach((prod) {
    if (prod.bestSelling == true) {
      _filterproduct.add(prod);
    } //best offer
  });

  await store.dispatch(BestSellAction(_filterproduct));
  store.state.inloading.bestproduct = false;
  store.dispatch(UpdateInloading(store.state.inloading));
};

class BestSellAction {
  final List<Product> _products;

  List<Product> get bestSellingProducts => this._products;

  BestSellAction(this._products);
}

///////////////////////////////
///
///
ThunkAction<AppState> servProdAction = (Store<AppState> store) async {
  http.Response response = await http.get(service_url);

  final List<dynamic> responseData = json.decode(response.body);

  List<Product> products = store.state.serviceProducts;
  final _prodleng = products.length;
  bool _hasmore = products.length + 9 <= responseData.length;
  for (var i = _prodleng; i < _prodleng + 10 && i < responseData.length; i++) {
    final Product product = Product.fromJson(responseData[i]);
    product.hasmore = _hasmore;
    products.add(product);
  }

  store.dispatch(ServProdAction(products));
  store.state.inloading.servproduct = false;
  store.dispatch(UpdateInloading(store.state.inloading));
};

class ServProdAction {
  final List<Product> _products;

  List<Product> get serviceProducts => this._products;

  ServProdAction(this._products);
}

class UpdateShowProduct {
  final List<Product> _products;

  List<Product> get serviceProducts => this._products;

  UpdateShowProduct(this._products);
}

////////////////////////////////
///
ThunkAction<AppState> catProdAction = (Store<AppState> store) async {
  List<Product> _allproducts = store.state.products;
  List<Product> _filterproduct = [];
  _allproducts.forEach((prod) {
    if (prod.bestSelling == false && prod.pet == 'Cat') {
      _filterproduct.add(prod);
    } //best offer
  });
  await store.dispatch(CatProdAction(_filterproduct));
  store.state.inloading.catproduct = false;
  store.dispatch(UpdateInloading(store.state.inloading));
};

class CatProdAction {
  final List<Product> _products;

  List<Product> get catProducts => this._products;

  CatProdAction(this._products);
}

//////////////////////////
///

// class MyAction {
//   String gender;
//   String name;
//   MyAction(this.gender, this.name);

ThunkAction<AppState> dogProdAction = (Store<AppState> store) async {
  List<Product> _allproducts = store.state.products;
  List<Product> _filterproduct = [];
  _allproducts.forEach((prod) {
    if (prod.bestSelling == false && prod.pet == 'Dog') {
      _filterproduct.add(prod);
    } //best offer
  });

  await store.dispatch(DogProdAction(_filterproduct));
  store.state.inloading.dogproduct = false;
  store.dispatch(UpdateInloading(store.state.inloading));
};

class DogProdAction {
  final List<Product> _products;

  List<Product> get dogProducts => this._products;

  DogProdAction(this._products);
}

///////////////////
///
///
///
///
///
// class MyAction {
//   String gender;
//   String name;
//   MyAction(this.gender, this.name);

ThunkAction<AppState> currentProdAction = (Store<AppState> store) async {
  http.Response response = await http.get(dog_url);

  final List<dynamic> responseData = json.decode(response.body);

  List<Product> products = store.state.dogProducts;
  final _prodleng = products.length;
  bool _hasmore = products.length + 9 <= responseData.length;
  for (var i = _prodleng; i < _prodleng + 10 && i < responseData.length; i++) {
    final Product product = Product.fromJson(responseData[i]);
    product.hasmore = _hasmore;
    products.add(product);
  }

  store.dispatch(CurrentProdAction(products));
  store.state.inloading.dogproduct = false;
  store.dispatch(UpdateInloading(store.state.inloading));
};
// }

class CurrentProdAction {
  final List<Product> _products;

  List<Product> get dogProducts => this._products;

  CurrentProdAction(this._products);
}
//////////////////////////////
///
///
///

List<Product> filterImage(_allproducts, _pet, _service, _category, _bestSelling,
    _limitedOffer, _subCategory) {
  List<Product> _filteredproduct = [];
  _allproducts.forEach((prod) {
    // if (// for best selling
    //   (_bestSelling == true && prod.bestSelling == _bestSelling) ||
    //     // for limited offer
    //     (_limitedOffer == true && prod.limitedOffer == _limitedOffer) ||
    //     // for service
    //     (_service == 'service' && prod.service == _service) ||
    //     // for product
    //     ((_service == 'product' &&
    //             _pet != 'outoffilter' &&
    //         (prod.pet == _pet || prod.pet == 'Both')) ||
    //         // For all category of Dog or cat
    //           ( _category == 'All')  || (_category == 'outoffilter')||
    //         (prod.category == _category) ||
    //     //
    //     (_category != 'outoffilter' &&
    //         (prod.pet == _pet || prod.pet == 'Both') &&
    //         (prod.category == _category || _category == 'All')) ||
    //     //

    //     (_subCategory != 'outoffilter' &&
    //         (prod.subCategory == _subCategory || _subCategory == 'All'))) {
    //   _filteredproduct.add(prod);
    // }
    //Best Selling
    if (_bestSelling == true && prod.bestSelling == _bestSelling) {
      _filteredproduct.add(prod);
    } //best offer
    else if (_limitedOffer == true && prod.limitedOffer == true) {
      _filteredproduct.add(prod);
    } //service
    else if (_service == 'service' && prod.service == 'service') {
      _filteredproduct.add(prod);
    } //show all products per PET
    // for subcateogry
    else if (_service == 'product' &&
        _category != 'outoffilter' &&
        _subCategory != 'outoffilter' &&
        prod.service == _service &&
        (prod.pet == _pet || prod.pet == 'Both') &&
        prod.category != null &&
        prod.category == _category &&
        prod.subCategory != null &&
        (prod.subCategory == _subCategory || _subCategory == 'All')) {
      _filteredproduct.add(prod);
    } //Show product per category
    else if (_service == 'product' &&
        _subCategory == 'outoffilter' &&
        prod.service == _service &&
        (prod.pet == _pet || prod.pet == 'Both') &&
        prod.category != null &&
        (prod.category == _category || _category == 'All')) {
      _filteredproduct.add(prod);
    }
    //Show product for pet

    else if (_service == 'product' &&
        _category == 'outoffilter' &&
        _subCategory == 'outoffilter' &&
        prod.service == _service &&
        (prod.pet == _pet || prod.pet == 'Both')) {
      _filteredproduct.add(prod);
    }
  });

  return _filteredproduct;
}

List<Product> loadmoreimages(_allproducts, _currentproduct) {
  List<Product> products = _currentproduct != null ? _currentproduct : [];
  final _prodleng = products.length;
  bool _hasmore = products.length + 9 < _allproducts.length;
  for (var i = _prodleng; i < _prodleng + 10 && i < _allproducts.length; i++) {
    final Product product = _allproducts[i];
    product.hasmore = _hasmore;
    products.add(product);
  }
  return products;
}

List<Product> searchproduct(_allproducts, _name) {
  List<Product> _filteredproduct = [];
  _name = _name.toLowerCase();
  _allproducts.forEach((prod) {
    if (prod.name.toLowerCase().contains(_name)) {
      _filteredproduct.add(prod);
    } //best offer
  });

  return _filteredproduct;
}
