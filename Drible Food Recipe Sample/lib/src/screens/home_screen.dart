// ignore_for_file: camel_case_types

import 'package:drible_food_recipe_app/src/models/category_model.dart';
import 'package:drible_food_recipe_app/src/models/food_model.dart';
import 'package:drible_food_recipe_app/src/screens/food_details_screen.dart';
import 'package:drible_food_recipe_app/src/screens/search_recipes_screen.dart';
import 'package:drible_food_recipe_app/src/widgets/custom_headline.dart';
import 'package:drible_food_recipe_app/src/widgets/custom_listtile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_google_font.dart';
import '../widgets/custom_seach_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              const _buildWelcome(),
              CustomSearchBar(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SearchResipesScreen(),
                    ),
                  );
                },
              ),
              CustomHeadline(
                seeAll: 'See all',
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.red,
                  size: 12,
                ),
                titleOfHeadline: 'Recomended for You',
                onTap: () {},
              ),
              _buildFoodSlider(foodModel: foodModel),
              CustomHeadline(
                seeAll: 'See all',
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.red,
                  size: 12,
                ),
                titleOfHeadline: 'Category',
                onTap: () {},
              ),
              _buildCategorySlider(categoryModel: categoryModel),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildWelcome extends StatelessWidget {
  const _buildWelcome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 16, 2, 0),
      child: CustomListTile(
        title: Text(
          'Hi David',
          style: GoogleFonts.getFont(
            'Varela Round',
            textStyle: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
          ),
        ),
        subTitle: Text(
          'What do u want to cook today?',
          style: GoogleFonts.getFont(
            'Varela Round',
            textStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ),
        trailing: const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/avatar/avatar.jpeg'),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

class _buildFoodSlider extends StatelessWidget {
  const _buildFoodSlider({
    Key? key,
    required this.foodModel,
  }) : super(key: key);

  final List<FoodModel> foodModel;

  @override
  Widget build(BuildContext context) {
    var foodModelShuffle = foodModel..shuffle();
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: foodModelShuffle.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var foodModelIndex = foodModelShuffle[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FoodDetailsScreen(
                    foodModel: foodModelIndex,
                  ),
                ),
              );
            },
            child: _buildFoodCard(
              food: foodModelIndex,
            ),
          );
        },
      ),
    );
  }
}

class _buildCategorySlider extends StatelessWidget {
  const _buildCategorySlider({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);

  final List<CategoryModel> categoryModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        itemCount: categoryModel.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _buildCategoryCard(
            category: categoryModel[index],
          );
        },
      ),
    );
  }
}

class _buildCategoryCard extends StatelessWidget {
  final CategoryModel category;
  const _buildCategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Ink(
              width: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 5,
                    color: Colors.black26,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      _buildCategoryBackground(category: category),
                      _buildCategoryImage(category: category),
                    ],
                  ),
                  _buildCategoryNameAndNumOfRecipies(category: category),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _buildCategoryNameAndNumOfRecipies extends StatelessWidget {
  const _buildCategoryNameAndNumOfRecipies({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomGoogleFontText(
            text: category.name,
            textStyle: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomGoogleFontText(
            text: category.numOfRecipies,
            textStyle: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _buildCategoryImage extends StatelessWidget {
  const _buildCategoryImage({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      left: 0,
      right: 0,
      child: Image(
        height: 110,
        image: AssetImage(
          category.image,
        ),
      ),
    );
  }
}

class _buildCategoryBackground extends StatelessWidget {
  const _buildCategoryBackground({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Container(
        height: 120,
        color: category.backgroundColor,
      ),
    );
  }
}

class _buildFoodCard extends StatelessWidget {
  final FoodModel food;
  const _buildFoodCard({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 5,
                    color: Colors.black26,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFoodImage(food: food),
                  _buildFoodName(food: food),
                  _buildFoodRating(food: food),
                  _buildSeparator(size: size),
                  _buildCookTimeAndDifficulty(food: food),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _buildCookTimeAndDifficulty extends StatelessWidget {
  const _buildCookTimeAndDifficulty({
    Key? key,
    required this.food,
  }) : super(key: key);

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
              ),
              const SizedBox(
                width: 4,
              ),
              CustomGoogleFontText(
                text: '${food.cookTime} mins',
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.outdoor_grill_outlined),
              const SizedBox(
                width: 4,
              ),
              CustomGoogleFontText(
                text: food.difficulty,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _buildSeparator extends StatelessWidget {
  const _buildSeparator({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 1,
        width: size.width,
        color: Colors.grey[200],
      ),
    );
  }
}

class _buildFoodImage extends StatelessWidget {
  final FoodModel food;
  const _buildFoodImage({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Image(
        
        image: AssetImage(food.image),
      ),
    );
  }
}

class _buildFoodName extends StatelessWidget {
  const _buildFoodName({
    Key? key,
    required this.food,
  }) : super(key: key);

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: CustomGoogleFontText(
        text: food.name,
        textStyle: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _buildFoodRating extends StatelessWidget {
  const _buildFoodRating({
    Key? key,
    required this.food,
  }) : super(key: key);

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Row(
        children: [
          Icon(
            Icons.star_rounded,
            size: 25,
            color: Colors.amber[700],
          ),
          CustomGoogleFontText(
            text: food.midRating.toString(),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          CustomGoogleFontText(
            text: '(${food.numOfRating} ratings)',
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
