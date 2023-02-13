import 'package:hive/hive.dart';
import 'package:papa_burger/src/restaurant.dart';

class LocalStorageRepository implements BaseLocalStorageRepository {
  String boxName = 'cart_items';
  Type boxType = Item;

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Item>(boxName);
    return box;
  }

  @override
  Future<void> addItemToCart(Box box, Item cartItem) async {
    await box.put(cartItem.name, cartItem);
  }

  @override
  Future<void> addRestaurantIdToCart(Box box, int restaurantId) async {
    await box.put(restaurantId.toString(), restaurantId);
  }

  @override
  Set<Item> getItemsFromStorage(Box box) {
    return box.values.toSet() as Set<Item>;
  }

  @override
  Future<void> removeAllItemsFromCart(Box box) async {
    await box.clear();
  }

  @override
  Future<void> removeItemFromCart(Box box, Item cartItem) async {
    await box.delete(cartItem.name);
  }

  // @override
  // int getRestaurantIdInCart(Box box) {
  //   return box.values.first as int;
  // }
}
