import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:papa_burger/src/restaurant.dart';

class CategoriesSlider extends StatelessWidget {
  const CategoriesSlider({super.key, required this.restaurants});

  final List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    final filteredRestaurants =
        restaurants.map((e) => e.tags.map((e) => e.name).toList()).toList();

    final restaurantsCateg =
        filteredRestaurants.expand((element) => element).toList();

    restaurantsCateg.sort();

    final Set<String> setRestaurantName = Set.from(restaurantsCateg);
    final categName = setRestaurantName.toList();

    return SizedBox(
      height: 50,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultHorizontalPadding,
        ),
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 12,
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: categName.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              final filteredRestaurants = restaurants
                  .where((element) => element.tags
                      .map((e) => e.name)
                      .contains(categName[index]))
                  .toList();
              Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                    child: FilteredRestaurantsView(
                      filteredRestaurants: filteredRestaurants,
                    ),
                    type: PageTransitionType.fade,
                  ),
                  (route) => true);
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
                  text: categName[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
