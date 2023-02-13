import 'package:hive/hive.dart';
import 'package:papa_burger/src/restaurant.dart';

class LocalStorageRepository with BaseLocalStorageRepository {
  static const String cart = 'cart_items';
  static const String restaurantId = 'restaurant_id';

  @override
  Future<Box> openBoxCart() async {
    Box box = await Hive.openBox<Item>(cart);
    return box;
  }

  @override
  Future<Box> openBoxRestaurantId() async {
    Box box = await Hive.openBox<Restaurant>(restaurantId);
    return box;
  }

  @override
  Future<void> addItemToCart(Box box, Item cartItem) async {
    await box.put(cartItem.name, cartItem);
  }

  @override
  Future<void> addRestaurantIdToCart(Box box, Restaurant restaurant) async {
    await box.put(restaurant.name, restaurant);
  }

  @override
  Set<Item> getItemsFromStorage(Box box) {
    return box.values.toSet() as Set<Item>;
  }

  @override
  Stream<int> getRestaurantIdFromStorage(Box box) async* {
    logger.i('stream emitted');
    if (box.values.isEmpty) yield 1;
    yield 2;
  }

  @override
  Future<void> removeAllItemsFromCart(Box box) async {
    await box.clear();
  }

  @override
  Future<void> removeItemFromCart(Box box, Item cartItem) async {
    await box.delete(cartItem.name);
  }

  @override
  Future<void> removeRestaurantIdFromCart(
      Box box, Restaurant restaurant) async {
    await box.delete(restaurant.name);
  }
}
