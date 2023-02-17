import 'package:bloc/bloc.dart';
import 'package:papa_burger/src/restaurant.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit({
    required this.api,
  }) : super(
          RestaurantState(),
        );

  final RestaurantApi api;

  Future<void> getRestaurants() async {
    try {
      final restaurants = await api.getListRestaurants();
      emit(
        state.copyWtih(
          restaurants: restaurants,
        ),
      );
    } catch (e) {
      logger.d(e.toString(), 'error in restaurant cubit');
    }
  }
}
