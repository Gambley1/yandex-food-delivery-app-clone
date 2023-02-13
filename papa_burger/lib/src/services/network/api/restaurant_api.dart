import 'package:dio/dio.dart';
import 'package:papa_burger/src/restaurant.dart';

class RestaurantApi {
  RestaurantApi({
    Dio? dio,
    UrlBuilder? urlBuilder,
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

  Future<List<Restaurant>> getListRestaurants(Map<String, dynamic> json) async {
    try {
      final List restaurants = json['restaurants'];
      return restaurants
          .map<Restaurant>(
            (rest) => Mapper.restaurantFromJson(rest),
          )
          .toList();
    } catch (e) {
      logger.d(e.toString(), 'restaurant error');
      rethrow;
    }
  }
}
