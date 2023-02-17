import 'package:equatable/equatable.dart';
import 'package:papa_burger/src/restaurant.dart';

enum CartStatus {
  init,
  loading,
  loaded,
  error,
}

class CartState extends Equatable {
  const CartState({
    this.restaurantId = 0,
    this.numOfMeals = 1,
    this.cartModel = const CartModel(),
    this.cartStatus = CartStatus.init,
  });
  final int numOfMeals;
  final int restaurantId;
  final CartModel cartModel;
  final CartStatus cartStatus;

  CartState copyWith({
    int? numOfMeals,
    int? restaurantId,
    CartModel? cartModel,
    CartStatus? cartStatus,
  }) {
    return CartState(
      numOfMeals: numOfMeals ?? this.numOfMeals,
      restaurantId: restaurantId ?? this.restaurantId,
      cartModel: cartModel ?? this.cartModel,
      cartStatus: cartStatus ?? this.cartStatus,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        numOfMeals,
        restaurantId,
        cartModel,
        cartStatus,
      ];
}
