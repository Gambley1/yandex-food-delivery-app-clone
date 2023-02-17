import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:papa_burger/src/restaurant.dart';

class RestaurantsCard extends StatelessWidget {
  const RestaurantsCard({
    super.key,
    required this.restaurants,
  });

  final List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final restaurant = restaurants[index];

            final String restaurantName = restaurant.name;
            final String restaurantImageUrl = restaurant.imageUrl;

            final List<Tag> restaurantTags = restaurant.tags;
            final List<String> tags =
                restaurantTags.map((e) => e.name).toList();

            final double rating = restaurant.rating;
            final int numOfRatings = restaurant.numOfRatings;
            final String quality = restaurant.quality;

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
          childCount: restaurants.length,
        ),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.restaurantImageUrl,
    required this.restaurantName,
    required this.rating,
    required this.quality,
    required this.numOfRatings,
    required this.tags,
  });

  final Restaurant restaurant;
  final String restaurantImageUrl;
  final String restaurantName;
  final double rating;
  final String quality;
  final int numOfRatings;
  final List<String> tags;

  _buildRestaurantInfo(
          double rating, String quality, int numOfRatings, List<String> tags) =>
      Row(
        children: [
          _buildRating(rating),
          _buildQualityAndNumOfRatings(quality, numOfRatings),
          _buildTags(tags),
        ],
      );

  _buildRating(double rating) => Row(
        children: [
          const CustomIcon(
            icon: FontAwesomeIcons.star,
            size: 16,
            color: Colors.green,
            type: IconType.simpleIcon,
          ),
          KText(
            text: " ${rating.toString()} ",
          ),
        ],
      );

  _buildQualityAndNumOfRatings(
    String quality,
    int numOfRatings,
  ) =>
      KText(
        text: restaurant.qualityAndNumOfRatings,
      );

  _buildTags(List<String> tags) => KText(
        text: restaurant.tagsToString,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultHorizontalPadding),
      child: InkWell(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              child: RestaurantMenusView(restaurant: restaurant),
              type: PageTransitionType.fade,
            ),
            (route) => true,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                      child: RestaurantMenusView(restaurant: restaurant),
                      type: PageTransitionType.fade,
                    ),
                    (route) => true,
                  );
                },
                child: CachedImage(
                  inkEffect: InkEffect.withEffect,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  imageType: CacheImageType.smallImage,
                  imageUrl: restaurantImageUrl,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: restaurantName,
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              _buildRestaurantInfo(rating, quality, numOfRatings, tags),
            ],
          ),
        ),
      ),
    );
  }
}
