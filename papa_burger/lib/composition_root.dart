import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papa_burger/src/restaurant.dart';

import 'src/config/theme/my_theme_data.dart';

class CompositionRoot {
  static late Api _userApi;
  static late Prefs _prefs;
  static late RestaurantApi _restaurantApi;
  static late UserRepository _userRepository;
  static late CartCubit _cartCubit;
  static late LocalStorageRepository _localStorageRepository;

  static configureApp() async {
    await Prefs.instance.init();
    await Hive.initFlutter();
    Hive.registerAdapter(ItemAdapter());
    Hive.registerAdapter(RestaurantAdapter());
    SystemChrome.setSystemUIOverlayStyle(MyThemeData.globalThemeData);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _localStorageRepository = LocalStorageRepository();
    _prefs = Prefs.instance;
    // _cartCubit = CartCubit(
    //   localStorageRepository: _localStorageRepository,
    // );

    // _userApi = Api(userTokenSupplier: () => Prefs.instance.getFromToken());
    _userApi = Api(prefs: _prefs);
    _userRepository = UserRepository(api: _userApi);
    _restaurantApi = RestaurantApi();
  }

  static Widget start() {
    MainPageBloc mainPageBloc = MainPageBloc(
      userRepository: _userRepository,
      api: _restaurantApi,
      cartCubit: _cartCubit,
    );
    RestaurantCubit restaurantCubit = RestaurantCubit(
      api: _restaurantApi,
    );
    NavigationCubit navigationCubit = NavigationCubit();
    CartCubit cartCubit =
        CartCubit(localStorageRepository: _localStorageRepository);
    LoginCubit loginCubit = LoginCubit(
      userRepository: _userRepository,
    );
    ShowPasswordCubit showPasswordCubit = ShowPasswordCubit();
    final String token = _prefs.getToken;
    final bool isAuthenticated = token.isNotEmpty ? true : false;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (contex) => mainPageBloc),
        BlocProvider(create: (context) => restaurantCubit),
        BlocProvider(create: (context) => navigationCubit),
        BlocProvider(create: (context) => cartCubit),
        BlocProvider(create: (context) => loginCubit),
        BlocProvider(create: (context) => showPasswordCubit),
      ],
      child: isAuthenticated ? const MainPageView() : const LoginView(),
    );
  }
}
