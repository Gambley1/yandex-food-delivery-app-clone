import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papa_burger/src/restaurant.dart';

class FilteredRestaurantsView extends StatelessWidget {
  final List<Restaurant> filteredRestaurants;

  const FilteredRestaurantsView({
    super.key,
    required this.filteredRestaurants,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<MainPageBloc, MainPageState>(
          listener: (context, state) {},
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultHorizontalPadding,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final restaurant = filteredRestaurants[index];

                        final restaurantName = restaurant.name;
                        final rating = restaurant.rating;
                        final quality = restaurant.quality;
                        final numOfRatings = restaurant.numOfRatings;
                        final listOfTags = restaurant.tags.toList();
                        final tags = listOfTags.map((e) => e.name).toList();

                        final restaurantImageUrl =
                            filteredRestaurants[index].imageUrl;

                        return RestaurantCard(
                          restaurant: restaurant,
                          restaurantImageUrl: restaurantImageUrl,
                          restaurantName: restaurantName,
                          rating: rating,
                          quality: quality,
                          numOfRatings: numOfRatings,
                          tags: tags,
                        );
                      },
                      childCount: filteredRestaurants.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
