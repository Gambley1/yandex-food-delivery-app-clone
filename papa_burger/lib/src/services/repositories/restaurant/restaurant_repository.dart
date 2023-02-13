import 'package:papa_burger/src/restaurant.dart';
import 'package:papa_burger/src/services/repositories/restaurant/base_restaurant_repository.dart';

class RestaurantRepository implements BaseRestaurantRepository {
  RestaurantRepository({
    required this.api,
  });

  final RestaurantApi api;

  @override
  Future<void> getListRestaurants(Map<String, dynamic> json) async {
    try {
      final restaurants = await api.getListRestaurants(json);
      logger.d(restaurants);
    } catch (e) {
      logger.d(e.toString(), 'restaurant error');
      rethrow;
    }
  }
}
