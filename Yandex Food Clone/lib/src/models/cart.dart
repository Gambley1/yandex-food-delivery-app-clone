import 'package:flutter/foundation.dart' show immutable;
import 'package:papa_burger/src/restaurant.dart';

@immutable
class Cart {
  final int restaurantId;
  final Set<Item> cartItems;

  const Cart({
    this.restaurantId = 0,
    this.cartItems = const <Item>{},
  });

  Cart copyWith({
    int? restaurantId,
    Set<Item>? cartItems,
  }) {
    return Cart(
      restaurantId: restaurantId ?? this.restaurantId,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}
