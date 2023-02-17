import 'package:flutter/foundation.dart' show immutable;
import 'package:hive/hive.dart';
import 'package:papa_burger/src/restaurant.dart';
import 'package:rxdart/rxdart.dart';

// @immutable
// class CartBloc {
//   final Sink<Item> items;
//   final Stream<CartItems> cartItems;
//
//   final LocalStorageRepository localStorageRepository =
//       LocalStorageRepository();
//
//   CartBloc._privateConstructor({
//     required this.items,
//     required this.cartItems,
//   });
//
//   void dispose() {
//     items.close();
//   }
//
//   factory CartBloc({
//     required CartApi api,
//   }) {
//     final cartSubject = BehaviorSubject<Item>();

//     const Cart cart = Cart();

//     final itemsStream = cartSubject
//         .distinct()
//         .debounceTime(const Duration(milliseconds: 300))
//         .switchMap((Item item) {
//       logger.i(item);
//       return Rx.fromCallable(() => api.addToCartItem(item))
//           .delay(const Duration(seconds: 1))
//           .map((event) => event.isEmpty
//               ? const CartItemsNoItems()
//               : CartItemsWithItems(cart.copyWith(cartItems: event)))
//           .onErrorReturnWith((error, _) => CartItemsHasError(error))
//           .startWith(const CartItemsLoading());
//     });

//     return CartBloc._privateConstructor(
//         items: cartSubject, cartItems: itemsStream);
//   }

// }

@immutable
class CartBloc {
  final LocalStorageRepository _localStorageRepository;
  final RestaurantApi _restaurantApi;

  CartBloc(
      {LocalStorageRepository? localStorageRepository,
      RestaurantApi? restaurantApi})
      : _localStorageRepository =
            localStorageRepository ?? LocalStorageRepository(),
        _restaurantApi = restaurantApi ?? RestaurantApi();

  final Cart cart = const Cart();

  final cachedCartItems = <Item>{};

  Restaurant getRestaurantById(int id) {
    final restaurantById = _restaurantApi.getRestaurantById(id);
    return restaurantById;
  }

  Stream<Set<Item>> get getItems {
    logger.i(cachedCartItems);
    return Rx.fromCallable(() => _getItemsFromCached()).map(
      (cachedItems) => cachedCartItems..addAll(cachedItems),
    );
  }

  Future<void> addToCart(Item item, int restaurantId) async {
    try {
      Box boxCart = await _localStorageRepository.openBoxCart();
      Box boxRestaurantId = await _localStorageRepository.openBoxRestaurantId();
      _localStorageRepository.addItemToCart(boxCart, item);
      _localStorageRepository.addRestaurantIdToCart(
          boxRestaurantId, restaurantId);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> removeItemsFromCart() async {
    try {
      Box boxCart = await _localStorageRepository.openBoxCart();
      Box boxRestaurantId = await _localStorageRepository.openBoxRestaurantId();
      _localStorageRepository.removeAllItemsFromCart(boxCart);
      _localStorageRepository.removeAllIdsFromCart(boxRestaurantId);
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<Set<Item>> _getItemsFromCached() async {
    Box boxCart = await _localStorageRepository.openBoxCart();
    final Set<Item> cachedItems =
        _localStorageRepository.getItemsFromStorage(boxCart);
    return cachedItems;
  }
}
