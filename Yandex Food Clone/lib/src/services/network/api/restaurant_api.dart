import 'package:dio/dio.dart';
import 'package:papa_burger/src/restaurant.dart';
import 'package:papa_burger/src/services/network/api/search_api.dart';

class RestaurantApi {
  RestaurantApi({
    Dio? dio,
    UrlBuilder? urlBuilder,
    SearchApi? searchApi,
  })  : _dio = dio ?? Dio(),
        _urlBuilder = urlBuilder ?? const UrlBuilder() {
    _dio.interceptors.add(LogInterceptor(
      responseBody: true,
    ));
    _dio.options.connectTimeout = 5 * 1000;
    _dio.options.receiveTimeout = 5 * 1000;
    _dio.options.sendTimeout = 5 * 1000;
  }

  final Dio _dio;
  final UrlBuilder _urlBuilder;

  // Future<List<Restaurant>> getRestaurants() async {
  //   try {
  //     final restaurants = await _searchApi.getRestaurants();
  //     return restaurants.isNotEmpty
  //         ? restaurants
  //             .map<Restaurant>((e) => Mapper.restaurantFromJson(e))
  //             .toList()
  //         : [];
  //   } catch (e) {
  //     logger.e(e.toString(), 'restaurant error');
  //     rethrow;
  //   }
  // }

  List<Restaurant> getListRestaurants() {
    try {
      final json = restaurantsJson();
      final List restaurants = json['restaurants'];
      return restaurants.isNotEmpty
          ? restaurants
              .map<Restaurant>(
                (rest) => Mapper.restaurantFromJson(rest),
              )
              .toList()
          : [];
    } catch (e) {
      logger.e(e.toString(), 'restaurant error');
      rethrow;
    }
  }

  Restaurant getRestaurantById(int id) {
    try {
      final restaurants = getListRestaurants();
      if (id == 0) return const Restaurant.empty();
      final restaurantById =
          restaurants.where((element) => element.id == id).first;
      return restaurantById;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }
}
