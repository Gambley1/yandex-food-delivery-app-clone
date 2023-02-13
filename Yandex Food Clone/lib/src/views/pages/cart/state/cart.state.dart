import 'dart:async';

import 'package:hive/hive.dart';
import 'package:papa_burger/src/restaurant.dart';
import 'package:rxdart/rxdart.dart';

class CartStateT {
  final _cartSubject = BehaviorSubject<CartState>(
    onListen: () => logger.i('listen to cart state subject'),
    onCancel: () => logger.w('canceling cart state subject'),
  );
  final _restaurantIdSubject = BehaviorSubject<int>(
    onListen: () => logger.i('listen to restaurantId subject'),
    onCancel: () => logger.w('canceling restaurantId subject'),
  );
  final _loadingSubject = BehaviorSubject<bool>(
    onListen: () => logger.i('listen to loading subject'),
    onCancel: () => logger.w('canceling loading subject'),
  );

  CartStateT({
    required LocalStorageRepository localStorageRepository,
  }) : _localStorageRepository = localStorageRepository;

  final LocalStorageRepository _localStorageRepository;

  CartState get state => const CartState();

  Stream<CartState> get cartStream =>
      _cartSubject.stream.distinct().debounceTime(const Duration(seconds: 1));
  Stream<int> get restaurantIdStream => _restaurantIdSubject.stream;
  Stream<bool> get loadingStream => _loadingSubject.stream;

  Future<void> initCart() async {
    _loadingSubject.sink.add(true);
    Box boxCart = await _localStorageRepository.openBoxCart();
    Set<Item> cartItems = _localStorageRepository.getItemsFromStorage(boxCart);
    if (cartItems.isEmpty) {
      return;
    } else {
      try {
        final initState = state.copyWith(
          cartModel: Cart(cartItems: cartItems),
        );
        _restaurantIdSubject.sink.add(0);
        _cartSubject.sink.add(initState);
        _loadingSubject.sink.add(false);
      } catch (_) {
        _loadingSubject.sink.add(false);
        logger.e('failed to load cart Items');
        logger.e('failed to load cart Items');
      }
    }
  }

  Future<void> addToCart(
      {required Item cartItem, required Restaurant restaurant}) async {
    _loadingSubject.sink.add(true);
    try {
      Box boxCart = await _localStorageRepository.openBoxCart();
      _localStorageRepository.addItemToCart(boxCart, cartItem);

      final int? id =
          await Cart(restaurant: restaurant).updateRestaurantCartId().first;

      final addItemState = CartState(
        cartModel: Cart(restaurant: restaurant).copyWith(
          cartItems: {
            ...CartState(
              cartModel: Cart(restaurant: restaurant, restaurantId: id!),
            ).cartModel.cartItems,
          }..add(cartItem),
        ),
      );
      _cartSubject.sink.add(addItemState);
      logger.i(
        CartState(
          cartModel: Cart(restaurant: restaurant),
        ).cartModel.cartItems,
      );
    } catch (e) {
      logger.e('failed to add to cart');
      logger.e(e.toString());
    }
  }

  Future<void> removeFromCart(
      {required Item cartItem, required Restaurant restaurant}) async {
    _loadingSubject.sink.add(true);
    try {
      final int? id =
          await Cart(restaurant: restaurant).updateRestaurantCartId().first;
      final removeState = state.copyWith(
        cartModel: Cart(
          cartItems: {...state.cartModel.cartItems}..remove(cartItem),
        ),
      );
      _restaurantIdSubject.sink.add(id!);
      _cartSubject.sink.add(removeState);
    } catch (e) {
      _loadingSubject.sink.add(false);
      logger.e('failed to remove from cart');
      logger.e(e.toString());
    }
  }
}
