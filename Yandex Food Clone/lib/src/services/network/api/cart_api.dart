import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:papa_burger/src/restaurant.dart';

class CartApi {
  CartApi({
    Dio? dio,
    LocalStorageRepository? localStorageRepository,
  })  : _dio = dio ?? Dio(),
        _localStorageRepository =
            localStorageRepository ?? LocalStorageRepository() {
    _dio.interceptors.add(LogInterceptor(
      responseBody: true,
    ));
    _dio.options.connectTimeout = 5 * 1000;
    _dio.options.receiveTimeout = 5 * 1000;
    _dio.options.sendTimeout = 5 * 1000;
  }

  final Dio _dio;
  final LocalStorageRepository _localStorageRepository;

  Future<Set<Item>> addToCartItem(
    Item item,
  ) async {
    try {
      Box boxCart = await _localStorageRepository.openBoxCart();
      _localStorageRepository.addItemToCart(boxCart, item);
      final Set<Item> cachedCartItems =
          _localStorageRepository.getItemsFromStorage(boxCart);
      const Cart().copyWith(cartItems: cachedCartItems);
      logger.i('added to cart $item');
      logger.i(cachedCartItems);
      return cachedCartItems;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }
}
