import 'package:papa_burger/src/restaurant.dart';

enum CartStatus {
  idle,
  empty,
  cartLoading,
  cartSucces,
  cartError,
}

class CartState {
  CartState({
    this.restaurantId = 0,
    this.cartItems = const {},
    this.cartStatus = CartStatus.idle,
    this.numOfMeals = 1,
  });
  final int restaurantId;
  final Set<Item> cartItems;
  final CartStatus cartStatus;
  final int numOfMeals;

  CartState copyWith({
    CartStatus? cartStatus,
    Set<Item>? cartItems,
    int? restaurantId,
    int? numOfMeals,
  }) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      cartItems: cartItems ?? this.cartItems,
      restaurantId: restaurantId ?? this.restaurantId,
      numOfMeals: numOfMeals ?? this.numOfMeals,
    );
  }
}
