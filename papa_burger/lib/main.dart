import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papa_burger/src/config/theme/my_theme_data.dart';
import 'package:papa_burger/src/restaurant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.instance.init();
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  SystemChrome.setSystemUIOverlayStyle(MyThemeData.globalThemeData);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late final _userApi = Api(
    userTokenSupplier: () => Prefs.instance.getFromToken(),
  );

  late final _restaurantApi = RestaurantApi();

  late final _userRepository = UserRepository(
    api: _userApi,
  );

  late final _restaurantRepository = RestaurantRepository(
    api: _restaurantApi,
  );

  late final bool isTokenEmpty = Prefs.instance.getToken == '' ? true : false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      splitScreenMode: true,
      builder: ((context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => RestaurantCubit(
                      api: _restaurantApi,
                    )),
            BlocProvider(
              create: (context) => CartCubit(
                localStorageRepository: LocalStorageRepository(),
              )..initCart(),
            ),
            BlocProvider(
              create: (context) => MainPageBloc(
                api: _restaurantApi,
              ),
            ),
            BlocProvider(
              create: (context) => NavigationCubit(),
            ),
            BlocProvider(
              create: (context) => LoginCubit(
                userRepository: _userRepository,
              ),
            ),
            BlocProvider(
              create: (context) => ShowPasswordCubit(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Papa Burger',
            themeMode: ThemeMode.light,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'Quicksand',
              brightness: Brightness.light,
              appBarTheme: const AppBarTheme(elevation: 0),
            ),
            home: isTokenEmpty
                ? LoginView(
                    userRepository: _userRepository,
                  )
                : MainPageView(
                    userRepository: _userRepository,
                  ),
          ),
        );
      }),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
