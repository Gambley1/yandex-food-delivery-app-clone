part of 'main_page_bloc.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object> get props => [];
}

class LoadMainPageEvent extends MainPageEvent {}

class ItemAddedToCartEvent extends MainPageEvent {
  final Item cartItem;

  const ItemAddedToCartEvent({required this.cartItem});
}

class ItemRemovedFromCartEvent extends MainPageEvent {
  final Item cartItem;

  const ItemRemovedFromCartEvent({required this.cartItem});
}

class AllMealRemovedFromCartEvent extends MainPageEvent {}

class IncreaseNumOfMeals extends MainPageEvent {
  final Item cartItem;

  const IncreaseNumOfMeals({required this.cartItem});
}

class DecreaseNumOfMeals extends MainPageEvent {
  final Item cartItem;

  const DecreaseNumOfMeals({required this.cartItem});
}

class FilterRestaurantsEvent extends MainPageEvent {
  final List<Restaurant> filteredRestaurants;

  const FilterRestaurantsEvent({required this.filteredRestaurants});
}
