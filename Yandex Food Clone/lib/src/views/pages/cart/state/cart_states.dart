import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:papa_burger/src/restaurant.dart';

@immutable
abstract class CartItems {
  const CartItems();
}

@immutable
class CartItemsWithItems implements CartItems {
  final Cart cart;
  const CartItemsWithItems(this.cart);
}

@immutable
class CartItemsNoItems implements CartItems {
  const CartItemsNoItems();
}

@immutable
class CartItemsLoading implements CartItems {
  const CartItemsLoading();
}

@immutable
class CartItemsHasError implements CartItems {
  final Object error;
  const CartItemsHasError(this.error);
}
