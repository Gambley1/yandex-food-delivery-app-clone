import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:papa_burger/src/restaurant.dart';

class CartCubit extends Cubit<CartState> {
  final LocalStorageRepository _localStorageRepository;

  CartCubit({
    required LocalStorageRepository localStorageRepository,
  })  : _localStorageRepository = localStorageRepository,
        super(const CartState());

  StreamSubscription? _streamSubscription;
  StreamSubscription? _streamRestaurantId;

  Future<void> initCart() async {
    Box boxCart = await _localStorageRepository.openBoxCart();
    Box boxRestaurantId = await _localStorageRepository.openBoxRestaurantId();
    Set<Item> cartItems = _localStorageRepository.getItemsFromStorage(boxCart);
    

    _streamRestaurantId = _localStorageRepository
        .getRestaurantIdFromStorage(boxRestaurantId)
        .listen(
          (id) => emit(
            state.copyWith(restaurantId: id),
          ),
        );

    if (cartItems.isNotEmpty) {
      try {
        final initState = state.copyWith(
          restaurantId: 0,
          cartModel: Cart(
            cartItems: cartItems,
          ),
        );
        emit(initState);
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> addRestaurantIdInCart(Restaurant restaurant) async {
    try {
      Box boxRestaurantId = await _localStorageRepository.openBoxRestaurantId();
      _localStorageRepository.addRestaurantIdToCart(
        boxRestaurantId,
        restaurant,
      );
      _streamSubscription =
          Cart(restaurant: restaurant).updateRestaurantCartId().listen(
                (id) => emit(
                  state.copyWith(restaurantId: id),
                ),
              );
    } catch (e) {
      error();
    }
  }

  Future<void> addItemToCart(Item item, Restaurant restaurant) async {
    loading();
    try {
      Box boxCart = await _localStorageRepository.openBoxCart();
      Box boxRestaurantId = await _localStorageRepository.openBoxRestaurantId();

      _localStorageRepository.addItemToCart(boxCart, item);
      _localStorageRepository.addRestaurantIdToCart(
          boxRestaurantId, restaurant);
      _streamSubscription =
          Cart(restaurant: restaurant).updateRestaurantCartId().listen(
                (id) => emit(
                  state.copyWith(restaurantId: id),
                ),
              );
      await Future.delayed(
        const Duration(
          milliseconds: 500,
        ),
      );

      final addItemState = state.copyWith(
        cartModel: Cart(restaurant: restaurant).copyWith(
          restaurant: restaurant,
          cartItems: {...state.cartModel.cartItems}..add(item),
        ),
        cartStatus: CartStatus.loaded,
      );

      emit(addItemState);

      logger.i(state.restaurantId);
    } catch (e) {
      error();
    }
  }

  Future<void> addItemToCartAfterRemovingAll(
      Item item, Restaurant restaurant) async {
    loading();
    try {
      Box boxCart = await _localStorageRepository.openBoxCart();
      Box boxRestaurantId = await _localStorageRepository.openBoxRestaurantId();

      _localStorageRepository.removeAllItemsFromCart(boxCart);
      _localStorageRepository.removeRestaurantIdFromCart(
          boxRestaurantId, restaurant);
      _localStorageRepository.addItemToCart(boxCart, item);
      _localStorageRepository.addRestaurantIdToCart(
          boxRestaurantId, restaurant);
      _streamSubscription =
          Cart(restaurant: restaurant).updateRestaurantCartId().listen(
                (id) => emit(
                  state.copyWith(restaurantId: id),
                ),
              );
      await Future.delayed(
        const Duration(seconds: 1),
      );

      emit(
        state.copyWith(
          cartModel: Cart(
            cartItems: {...state.cartModel.cartItems}
              ..removeAll(state.cartModel.cartItems),
          ),
        ),
      );

      await Future.delayed(
        const Duration(seconds: 1),
      );

      emit(
        state.copyWith(
          cartModel: Cart(
            restaurant: restaurant,
            cartItems: {...state.cartModel.cartItems}..add(item),
          ),
          cartStatus: CartStatus.loaded,
        ),
      );

      logger.i(state.cartModel.cartItems);
      logger.i(state.cartModel.restaurant.id);
    } catch (e) {
      error();
    }
  }

  Future<void> removeItemFromCart(Item item, Restaurant restaurant) async {
    loading();
    try {
      Box boxCart = await _localStorageRepository.openBoxCart();
      Box boxRestaurantId = await _localStorageRepository.openBoxRestaurantId();

      _localStorageRepository.removeItemFromCart(boxCart, item);
      _localStorageRepository.removeRestaurantIdFromCart(
          boxRestaurantId, restaurant);
      _streamSubscription =
          Cart(restaurant: restaurant).updateRestaurantCartId().listen(
                (id) => emit(
                  state.copyWith(restaurantId: id),
                ),
              );
      await Future.delayed(
        const Duration(milliseconds: 500),
      );
      final removeItemState = state.copyWith(
        cartModel: Cart(
          restaurant: restaurant,
          cartItems: {
            ...state.cartModel.cartItems,
          }..remove(item),
        ),
        cartStatus: CartStatus.loaded,
      );

      emit(removeItemState);

      logger.i(state.restaurantId);
    } catch (e) {
      error();
    }
  }

  Future<void> removeAllItemFromCart() async {
    loading();
    try {
      Box boxCart = await _localStorageRepository.openBoxCart();

      _localStorageRepository.removeAllItemsFromCart(boxCart);
      _streamSubscription = Cart(restaurant: state.cartModel.restaurant)
          .updateRestaurantCartId()
          .listen(
            (id) => emit(
              state.copyWith(restaurantId: id),
            ),
          );
      await delay1Sec();
      final removeAllState = state.copyWith(
        cartModel: Cart(
          restaurant: const Restaurant(
            name: '',
            quality: '',
            imageUrl: '',
            id: 0,
            numOfRatings: 0,
            rating: 0,
            tags: [],
            menu: [],
          ),
          cartItems: {...state.cartModel.cartItems}
            ..removeAll(state.cartModel.cartItems),
        ),
        restaurantId: 0,
        cartStatus: CartStatus.loaded,
      );
      emit(removeAllState);
    } catch (e) {
      error();
    }
  }

  Future<void> delay1Sec() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
  }

  void loading() {
    emit(
      state.copyWith(
        cartStatus: CartStatus.loading,
      ),
    );
  }

  void succes() {
    emit(
      state.copyWith(
        cartStatus: CartStatus.loaded,
      ),
    );
  }

  void error() {
    emit(
      state.copyWith(
        cartStatus: CartStatus.error,
      ),
    );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    _streamRestaurantId?.cancel();
    logger.i('streams closed');
    return super.close();
  }
}
