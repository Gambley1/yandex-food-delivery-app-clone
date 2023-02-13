import 'package:hive/hive.dart';
import 'package:papa_burger/src/restaurant.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBoxCart();
  Future<Box> openBoxRestaurantId();
  Set<Item> getItemsFromStorage(Box box);
  Stream<int> getRestaurantIdFromStorage(Box box);
  Future<void> addItemToCart(Box box, Item cartItem);
  Future<void> addRestaurantIdToCart(Box box, Restaurant restaurant);
  Future<void> removeItemFromCart(Box box, Item cartItem);
  Future<void> removeRestaurantIdFromCart(Box box, Restaurant restaurant);
  Future<void> removeAllItemsFromCart(Box box);
}
