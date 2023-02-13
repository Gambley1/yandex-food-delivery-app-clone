import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:papa_burger/src/restaurant.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc({
    required this.api,
  }) : super(MainPageState()) {
    on<LoadMainPageEvent>(_onLoadMainPage);
    on<FilterRestaurantsEvent>(_onFindFilteredRestaurants);
  }

  final RestaurantApi api;

  Future<void> _onLoadMainPage(
      LoadMainPageEvent event, Emitter<MainPageState> emit) async {
    emit(
      state.copyWith(
        mainPageRequest: MainPageRequest.mainPageLoading,
      ),
    );
    try {
      // await Future.delayed(
      //   const Duration(seconds: 1),
      // );
      final restaurants = await api.getListRestaurants(
        restaurantsJson(),
      );
      emit(
        state.copyWith(
          restaurants: restaurants,
          mainPageRequest: MainPageRequest.requestSuccess,
        ),
      );
    } catch (_) {
      errorStateMainPage(emit);
    }
    logger.d('on load event');
  }

  Future<void> _onFindFilteredRestaurants(
      FilterRestaurantsEvent event, Emitter<MainPageState> emit) async {
    emit(
      state.copyWith(
        mainPageRequest: MainPageRequest.filterRequestLoading,
      ),
    );
    try {
      emit(
        state.copyWith(
          filteredRestaurants: [
            ...state.filteredRestaurants,
            ...event.filteredRestaurants,
          ],
          mainPageRequest: MainPageRequest.filterRequestSucces,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          mainPageRequest: MainPageRequest.filterRequestFailure,
        ),
      );
      logger.d('error whilte finding filtered restaurants');
    }
  }

  void errorStateCart(Emitter<MainPageState> emit) {
    emit(
      state.copyWith(
        cartRequest: CartRequest.requestFailure,
      ),
    );
    logger.d('cart error occured');
  }

  void errorStateMainPage(Emitter<MainPageState> emit) {
    emit(
      state.copyWith(
        mainPageRequest: MainPageRequest.mainPageRequestFailure,
      ),
    );
    logger.d('main page error occured');
  }
}
