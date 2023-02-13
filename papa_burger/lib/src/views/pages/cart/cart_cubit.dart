import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:papa_burger/src/restaurant.dart';

class CartCubit extends Cubit<CartState> {
  final LocalStorageRepository _localStorageRepository;

  CartCubit({required LocalStorageRepository localStorageRepository})
      : _localStorageRepository = localStorageRepository,
        super(CartState());

  Future<void> initCart() async {
    try {
      Box box = await _localStorageRepository.openBox();
      Set<Item> cartItems = _localStorageRepository.getItemsFromStorage(box);
      // int restairantId = _localStorageRepository.getRestaurantIdInCart(box);
      emit(
        state.copyWith(
          cartItems: cartItems,
          // restaurantId: restairantId,
        ),
      );
    } catch (e) {
      logger.d(e.toString());
      rethrow;
    }
  }

  Future<void> initRestaurantIdInCart(int restaurantId) async {
    try {
      emit(
        state.copyWith(
          restaurantId: restaurantId,
        ),
      );
    } catch (e) {
      error();
      logger.d(
        'error whilte initing restaurant id in cart',
        e.toString(),
      );
    }
  }

  Future<void> addItemToCart(Item item) async {
    loading();
    try {
      Box box = await _localStorageRepository.openBox();
      _localStorageRepository.addItemToCart(box, item);

      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );
      emit(
        state.copyWith(
          cartItems: {...state.cartItems}..add(item),
          cartStatus: CartStatus.cartSucces,
        ),
      );
    } catch (e) {
      error();
      logger.d(
        'error while adding single item to cart',
        e.toString(),
      );
    }
  }

  Future<void> addItemToCartAfterRemovingAll(
      Item item, int restaurantId) async {
    loading();
    try {
      Box box = await _localStorageRepository.openBox();
      _localStorageRepository.removeAllItemsFromCart(box);
      _localStorageRepository.addItemToCart(box, item);

      // int restaurantId = await _localStorageRepository.getRestaurantIdInCart();

      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );
      emit(
        state.copyWith(
          cartItems: {...state.cartItems}..removeAll(state.cartItems),
          restaurantId: 0,
        ),
      );
      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );
      emit(
        state.copyWith(
          cartItems: {...state.cartItems}..add(item),
          restaurantId: restaurantId,
          cartStatus: CartStatus.cartSucces,
        ),
      );
    } catch (e) {
      error();
      logger.d(
        'error while adding items to cart after removing all',
        e.toString(),
      );
    }
  }

  Future<void> removeItemFromCart(Item item, int restaurantId) async {
    loading();
    try {
      Box box = await _localStorageRepository.openBox();
      _localStorageRepository.removeItemFromCart(box, item);
      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );
      emit(
        state.copyWith(
          cartItems: {...state.cartItems}..remove(item),
          restaurantId: state.cartItems.isNotEmpty ? 0 : restaurantId,
          cartStatus: CartStatus.cartSucces,
        ),
      );
    } catch (e) {
      error();
      logger.d(
        'error while removing one item from cart',
        e.toString(),
      );
    }
  }

  Future<void> removeAllItemFromCart() async {
    loading();
    try {
      Box box = await _localStorageRepository.openBox();
      _localStorageRepository.removeAllItemsFromCart(box);
      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );
      emit(
        state.copyWith(
          cartItems: {...state.cartItems}..removeAll(state.cartItems),
          restaurantId: 0,
          cartStatus: CartStatus.cartSucces,
        ),
      );
      logger.d(
        state.restaurantId,
        state.cartItems,
      );
    } catch (e) {
      error();
      logger.d(
        'error while removing all items from cart',
        e.toString(),
      );
    }
  }

  void loading() {
    emit(
      state.copyWith(
        cartStatus: CartStatus.cartLoading,
      ),
    );
  }

  void succes() {
    emit(
      state.copyWith(
        cartStatus: CartStatus.cartSucces,
      ),
    );
  }

  void error() {
    emit(
      state.copyWith(
        cartStatus: CartStatus.cartError,
      ),
    );
  }
}
