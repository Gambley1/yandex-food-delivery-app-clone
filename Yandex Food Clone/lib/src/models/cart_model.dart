import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:papa_burger/src/restaurant.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class CartModel extends Equatable {
  final int restaurantId;
  final Set<Item> cartItems;

  const CartModel({
    this.restaurantId = 0,
    this.cartItems = const <Item>{},
  });

  const CartModel.empty()
      : restaurantId = 0,
        cartItems = const <Item>{};

  CartModel copyWith({
    int? restaurantId,
    Set<Item>? cartItems,
  }) =>
      CartModel(
        cartItems: cartItems ?? this.cartItems,
        restaurantId: restaurantId ?? this.restaurantId,
      );

  bool get isCartEmpty =>
      cartItems.isEmpty || cartItems == <Item>{} ? true : false;

  Stream<int> updateRestaurantCartId() async* {
    if (isCartEmpty) {
      yield 0;
    }
    yield restaurantId;
  }

  int get _minimumSubTotal => 30;

  double _subTotal() {
    final List<Item> listCartItems = List.from(cartItems);
    final double abc =
        listCartItems.fold(0, (total, current) => total + current.price);
    return abc;
  }

  int _deliveryFee() {
    final deliveryFee = _subTotal() < _minimumSubTotal ? 10 : 0;
    return deliveryFee;
  }

  double _addMoreForFreeDeliver() {
    return _minimumSubTotal - _subTotal();
  }

  double totalWithDeliveryFee() {
    if (_deliveryFee() == 0) return _subTotal();
    final totalWithDeliveryFee = _subTotal() + _deliveryFee();
    return totalWithDeliveryFee;
  }

  String freeDelivery() {
    if (_deliveryFee() == 0) return 'You have Free Delivery';
    return 'Add \$${_addMoreForFreeDeliver().toStringAsFixed(2)} for FREE Delivery';
  }

  @override
  List<Object?> get props => [
        restaurantId,
        cartItems,
      ];
}
