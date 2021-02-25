import 'package:pawpoint/models/address.dart';
import 'package:pawpoint/models/inloading.dart';
import 'package:pawpoint/models/order.dart';
import 'package:pawpoint/models/cart.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/models/user.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final User user;
  final InLoading inloading;
  final List<Product> products;
  final List<Product> favProducts;
  final List<Product> cartProducts;
  final List<Product> bestSellingProducts;
  final List<Product> catProducts;
  final List<Product> dogProducts;
  final List<Product> serviceProducts;
  final List<Cart> cartItems;
  final List<dynamic> cards;
  final List<Order> orders;
  final Order currentorder;
  final String cardToken;
  final double ordertotalprice;
  final List<ShippingAddress> shippingAddress;

  AppState({
    @required this.user,
    @required this.products,
    @required this.inloading,
    @required this.favProducts,
    @required this.cartProducts,
    @required this.cartItems,
    @required this.orders,
    @required this.cards,
    @required this.cardToken,
    @required this.ordertotalprice,
    @required this.shippingAddress,
    @required this.bestSellingProducts,
    @required this.catProducts,
    @required this.dogProducts,
    @required this.serviceProducts,
    @required this.currentorder,
  });

  factory AppState.initial() {
    return AppState(
      user: null,
      currentorder: Order(),
      inloading: InLoading(),
      orders: [],
      products: [],
      favProducts: [],
      cartProducts: [],
      bestSellingProducts: [],
      serviceProducts: [],
      catProducts: [],
      dogProducts: [],
      cartItems: [],
      cards: [],
      cardToken: '',
      ordertotalprice: 0,
      shippingAddress: [],
    );
  }
}
