import 'package:equatable/equatable.dart';
import 'package:papa_burger/src/restaurant.dart';

class Cart extends Equatable {
  final int restaurantId;
  final Restaurant restaurant;
  final Set<Item> cartItems;

  const Cart({
    this.restaurantId = 0,
    this.restaurant = const Restaurant(
      name: '',
      quality: '',
      imageUrl: '',
      id: 0,
      numOfRatings: 0,
      rating: 0,
      tags: [],
      menu: [],
    ),
    this.cartItems = const <Item>{},
  });

  Cart copyWith({
    Restaurant? restaurant,
    Set<Item>? cartItems,
  }) =>
      Cart(
        restaurant: restaurant ?? this.restaurant,
        cartItems: cartItems ?? this.cartItems,
      );

  bool get isCartEmpty =>
      cartItems.isEmpty || cartItems == <Item>{} ? true : false;

  Restaurant get cartRestaurant => restaurant;

  Stream<int?> updateRestaurantCartId() async* {
    if (isCartEmpty) {
      yield 0;
    }
    yield restaurant.id;
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
        restaurant,
        cartItems,
      ];
}
