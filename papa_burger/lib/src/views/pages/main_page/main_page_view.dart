import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:papa_burger/src/config/theme/my_theme_data.dart';
import 'package:papa_burger/src/restaurant.dart';
import 'package:papa_burger/src/views/pages/main_page/components/filtered_restaurants_view.dart';

final _globalBucket = PageStorageBucket();

class MainPageView extends StatelessWidget {
  const MainPageView({
    super.key,
    required this.userRepository,
  });

  final UserRepository userRepository;

  final String title = 'What do you want today Sir?';

  _appBar(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Row(
          children: [
            CustomIcon(
              type: IconType.iconButton,
              size: 24,
              onPressed: () {},
              icon: FontAwesomeIcons.barsStaggered,
            ),
            const Spacer(),
            CustomIcon(
              type: IconType.iconButton,
              size: 24,
              onPressed: () {},
              icon: FontAwesomeIcons.solidBell,
            ),
            const SizedBox(
              width: 12,
            ),
            CustomIcon(
              type: IconType.iconButton,
              size: 24,
              onPressed: () {},
              icon: FontAwesomeIcons.cartShopping,
            ),
            const SizedBox(
              width: 12,
            ),
            CustomIcon(
              type: IconType.iconButton,
              size: 24,
              onPressed: () {
                context.read<CartCubit>().removeAllItemFromCart();
                userRepository.api.signOut().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            child: LoginView(
                              userRepository: userRepository,
                            ),
                            type: PageTransitionType.fade,
                          ),
                          (route) => true),
                    );
              },
              icon: FontAwesomeIcons.arrowRightFromBracket,
            ),
          ],
        ),
      );

  _title(double size, String title) => Padding(
        padding: const EdgeInsets.only(
          right: 100,
        ),
        child: SizedBox(
          width: size * 0.6,
          child: KText(
            text: title,
            size: 26,
          ),
        ),
      );

  _searchBar(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GestureDetector(
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              child: const SearchView(),
              type: PageTransitionType.fade,
            ),
            (route) => true,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: HexColor('#EEEEEE'),
                borderRadius: BorderRadius.circular(24)),
            child: const AppInputText(
              enabled: false,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              labelText: 'Search...',
              borderRadius: 24,
              prefixIcon: Icon(
                FontAwesomeIcons.magnifyingGlass,
              ),
            ),
          ),
        ),
      );

  _categoriesSlider(BuildContext context, List<Tag?> categories, double size) {
    findFilteredRestaurants(List<Restaurant> restaurants) {
      context.read<MainPageBloc>().add(
            FilterRestaurantsEvent(
              filteredRestaurants: restaurants,
            ),
          );
    }

    return BlocConsumer<MainPageBloc, MainPageState>(
      listenWhen: (previous, current) =>
          previous.filteredRestaurants.length !=
          current.filteredRestaurants.length,
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 15,
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final filteredRestaurants = state.restaurants
                      .where(
                        (element) => element.tags.map((e) => e.name).contains(
                              categories[index]!.name,
                            ),
                      )
                      .toList();

                  findFilteredRestaurants(filteredRestaurants);
                  logger.d(filteredRestaurants);
                  logger.d(state.filteredRestaurants);
                  logger.d(state.mainPageRequest);
                  // logger.d(state.meals
                  //     .where((meal) =>
                  //         meal.categorie.tag.contains(categories[index]!.tag))
                  //     .toList());
                },
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.grey.shade50,
                        Colors.grey.shade200,
                        Colors.grey.shade200
                      ],
                      stops: const [
                        0.2,
                        0.5,
                        0.7,
                      ],
                    ).createShader(bounds);
                  },
                  child: Chip(
                    label: KText(
                      text: categories[index]!.name,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  _bottomNavigationBar(BuildContext context) {
    final cubit = context.read<NavigationCubit>();
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: primaryColor,
        backgroundColor: Colors.white,
        labelTextStyle: MaterialStateProperty.all(
          GoogleFonts.getFont(
            'Quicksand',
            textStyle: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
      child: NavigationBar(
        animationDuration: const Duration(
          microseconds: 500,
        ),
        selectedIndex: cubit.state.currentIndex,
        onDestinationSelected: (value) {
          cubit.navigation(value);
          if (cubit.state.currentIndex == 3) {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                child: CartView(
                  userRepository: userRepository,
                ),
                type: PageTransitionType.fade,
              ),
              (route) => true,
            );
          }
        },
        height: 60,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.house,
              color: Colors.grey,
              size: 20,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.house,
              size: 21,
              color: Colors.black,
            ),
            label: 'Main',
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.burger,
              color: Colors.grey,
              size: 20,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.burger,
              size: 21,
              color: Colors.black,
            ),
            label: 'Restaurants',
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.listUl,
              size: 20,
              color: Colors.grey,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.listUl,
              size: 21,
              color: Colors.black,
            ),
            label: 'Order List',
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.basketShopping,
              color: Colors.grey,
              size: 20,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.basketShopping,
              size: 21,
              color: Colors.black,
            ),
            label: 'Cart',
          ),
        ],
      ),
    );
  }

  _buildListRestaurants(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 24,
      ),
      sliver: BlocConsumer<MainPageBloc, MainPageState>(
        listenWhen: (previous, current) =>
            previous.restaurants.length != current.restaurants.length,
        listener: (context, state) {},
        builder: (context, state) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final restaurantTags = state.restaurants[index].tags;
                final tags = restaurantTags.map((e) => e.name).toList();

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      PageTransition(
                        child: RestaurantMenusView(
                          restaurant: state.restaurants[index],
                        ),
                        type: PageTransitionType.fade,
                      ),
                      (route) => true,
                    );
                  },
                  child: Card(
                    elevation: 6,
                    child: Column(
                      children: [
                        KText(
                          text: state.restaurants[index].name,
                        ),
                        KText(
                          text: state.restaurants[index].id.toString(),
                        ),
                        KText(
                          text: tags
                              .toString()
                              .replaceAll('[', '')
                              .replaceAll(']', ''),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: state.restaurants.length,
            ),
          );
        },
      ),
    );
  }

  _buildMainPage(
    BuildContext context,
  ) {
    void tryAgain() {
      context.read<MainPageBloc>().add(LoadMainPageEvent());
    }

    final cubit = context.read<NavigationCubit>();

    List<Tag> categories = MockCategories.tags;

    return BlocConsumer<NavigationCubit, NavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () => _releaseFocus(context),
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                extendBody: true,
                bottomNavigationBar: _bottomNavigationBar(context),
                body: SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      switch (cubit.state.currentIndex) {
                        case 0:
                          return BlocConsumer<MainPageBloc, MainPageState>(
                            listenWhen: (previous, current) =>
                                previous.mainPageRequest !=
                                current.mainPageRequest,
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state.mainPageRequest ==
                                  MainPageRequest.mainPageLoading) {
                                return const CustomCircularIndicator(
                                  color: Colors.black,
                                );
                              } else if (state.mainPageRequest ==
                                  MainPageRequest.filterRequestSuccess) {
                                FilteredRestaurantsView(
                                  filteredRestaurants:
                                      state.filteredRestaurants,
                                );
                              } else if (state.mainPageRequest ==
                                  MainPageRequest.mainPageFailure) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const KText(
                                        text: 'Error occured.',
                                        size: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          tryAgain();
                                        },
                                        child: const KText(text: 'Try again'),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (state.mainPageRequest ==
                                  MainPageRequest.requestSuccess) {
                                final size = MediaQuery.of(context).size.width;

                                return Stack(
                                  children: [
                                    _appBar(context),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 56),
                                      child: CustomScrollView(
                                        key: const PageStorageKey<String>(
                                          'main_page_key',
                                        ),
                                        physics: const BouncingScrollPhysics(
                                            parent:
                                                AlwaysScrollableScrollPhysics()),
                                        scrollDirection: Axis.vertical,
                                        slivers: [
                                          SliverToBoxAdapter(
                                            child: Column(
                                              children: [
                                                _title(size, title),
                                                const SizedBox(
                                                  height: 26,
                                                ),
                                                _searchBar(context),
                                                const SizedBox(
                                                  height: 26,
                                                ),
                                                _categoriesSlider(
                                                    context, categories, size),
                                                const SizedBox(
                                                  height: 13,
                                                ),
                                              ],
                                            ),
                                          ),
                                          _buildListRestaurants(context),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const KText(
                                      text: 'Something went wrong.',
                                      size: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        tryAgain();
                                      },
                                      child: const KText(text: 'Try again'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        case 1:
                          return RestaurantView(userRepository: userRepository);
                        case 2:
                          return OrdersView(userRepository: userRepository);
                      }
                      return Container();
                    },
                  ),
                )),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      key: const PageStorageKey<String>('global_key'),
      bucket: _globalBucket,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: MyThemeData.globalThemeData,
        child: Builder(
          builder: (context) => _buildMainPage(context),
        ),
      ),
    );
  }

  void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();
}
