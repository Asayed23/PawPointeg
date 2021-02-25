import 'package:pawpoint/models/inloading.dart';
import 'package:pawpoint/models/order.dart';
import 'package:pawpoint/models/product.dart';
import 'package:pawpoint/models/address.dart';
import 'package:pawpoint/models/user.dart';
import 'package:pawpoint/models/cart.dart';
import 'package:pawpoint/redux/actions/actions.dart';
import 'package:pawpoint/redux/actions/add_action.dart';
import 'package:pawpoint/redux/actions/card_action.dart';
import 'package:pawpoint/redux/actions/category_action.dart';
import 'package:pawpoint/redux/actions/fav_action.dart';
import 'package:pawpoint/redux/actions/inloading_action.dart';
import 'package:pawpoint/redux/actions/order_action.dart';
import 'package:pawpoint/redux/state/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: userReducer(state.user, action),
    products: productsReducer(state.products, action),
    cartProducts: cartProducts(state.cartProducts, action),
    bestSellingProducts: bestSellingProducts(state.bestSellingProducts, action),
    serviceProducts: serviceProducts(state.serviceProducts, action),
    catProducts: catProducts(state.catProducts, action),
    dogProducts: dogProducts(state.dogProducts, action),
    cards: cardsReducer(state.cards, action),
    cardToken: cardTokenReducer(state.cardToken, action), //cardToken
    cartItems: cartItems(state.cartItems, action),
    favProducts: favProducts(state.favProducts, action),
    orders: ordersReducer(state.orders, action),
    currentorder: currentorderReducer(state.currentorder, action),
    inloading: inloadingReducer(state.inloading, action),
    ordertotalprice: ordertotalpriceReduce(state.ordertotalprice, action),
    shippingAddress: shippingAddress(state.shippingAddress, action),
  );
}

List<Product> bestSellingProducts(
    List<Product> bestSellingProducts, dynamic action) {
  if (action is BestSellAction) {
    return action.bestSellingProducts;
  }
  return bestSellingProducts;
}

Order currentorderReducer(Order currentorder, dynamic action) {
  if (action is Updatecurrentorder) {
    return action.order;
  }
  return currentorder;
}

InLoading inloadingReducer(InLoading inloading, dynamic action) {
  if (action is UpdateInloading) {
    return action.inloading;
  }
  return inloading;
}

List<Product> serviceProducts(List<Product> serviceProducts, dynamic action) {
  if (action is ServProdAction) {
    return action.serviceProducts;
  } else if (action is UpdateShowProduct) {
    return action.serviceProducts;
  }
  return serviceProducts;
}

List<Product> catProducts(List<Product> catProducts, dynamic action) {
  if (action is CatProdAction) {
    return action.catProducts;
  }
  return catProducts;
}

List<Product> dogProducts(List<Product> dogProducts, dynamic action) {
  if (action is DogProdAction) {
    return action.dogProducts;
  }
  return dogProducts;
}

List<Product> estSellingProducts(
    List<Product> bestSellingProducts, dynamic action) {
  if (action is BestSellAction) {
    return action.bestSellingProducts;
  }
  return bestSellingProducts;
}

List<ShippingAddress> shippingAddress(
    List<ShippingAddress> shippingAddress, dynamic action) {
  if (action is GetAddAction) {
    return action.adresss;
  } else if (action is AddadressAction) {
    return action.adresss;
  }
  return shippingAddress;
}

double ordertotalpriceReduce(double ordertotalprice, dynamic action) {
  if (action is Getordertotalprice) {
    return action.ordertotalprice;
  }
  return ordertotalprice;
}

User userReducer(User user, dynamic action) {
  if (action is GetUserAction) {
    return action.user;
  } else if (action is LogoutUserAction) {
    return action.user;
  } else if (action is UpdateUserAction) {
    return action.user;
  }
  return user;
}

List<Product> productsReducer(List<Product> products, dynamic action) {
  if (action is GetProductsAction) {
    return action.products;
  }
  return products;
}

List<Product> cartProducts(List<Product> cartProducts, dynamic action) {
  if (action is GetCartProductsAction) {
    return action.cartProducts;
  } else if (action is ToggleCartProductAction) {
    return action.cartProducts;
  } else if (action is ClearCartProductsAction) {
    return action.cartProducts;
  } else if (action is UpdateQuantityAction) {
    return action.cartProducts;
  }
  return cartProducts;
}

List<Product> favProducts(List<Product> favProducts, dynamic action) {
  if (action is GetFavProductsAction) {
    return action.favProducts;
  } else if (action is ToggleFavProductAction) {
    return action.favProducts;
  }
  return favProducts;
}

List<Cart> cartItems(List<Cart> cartItems, dynamic action) {
  if (action is GetcartItemsAction) {
    return action.cartItems;
  }

  return cartItems;
}

List<dynamic> cardsReducer(List<dynamic> cards, dynamic action) {
  if (action is GetCardsAction) {
    return action.cards;
  } else if (action is AddCardAction) {
    return List.from(cards)..add(action.card);
  }
  return cards;
}

String cardTokenReducer(String cardToken, dynamic action) {
  if (action is GetCardTokenAction) {
    return action.cardToken;
  } else if (action is UpdateCardTokenAction) {
    return action.cardToken;
  }
  return cardToken;
}

List<Order> ordersReducer(List<Order> orders, dynamic action) {
  if (action is GetHistoryOrder) {
    return action.orders;
  }

  return orders;
}
