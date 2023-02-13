import 'package:hive/hive.dart';
import 'package:papa_burger/src/restaurant.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBox();
  Set<Item> getItemsFromStorage(Box box);
  // int getRestaurantIdInCart(Box box);
  Future<void> addItemToCart(Box box, Item cartItem);
  Future<void> addRestaurantIdToCart(Box box, int restaurantId);
  Future<void> removeItemFromCart(Box box, Item cartItem);
  Future<void> removeAllItemsFromCart(Box box);
}
