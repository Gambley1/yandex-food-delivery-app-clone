// ignore_for_file: unused_local_variable, camel_case_types

import 'package:drible_food_recipe_app/src/models/food_model.dart';
import 'package:drible_food_recipe_app/src/widgets/custom_headline.dart';
import 'package:flutter/material.dart';

import '../models/found_recipes.dart';
import '../widgets/custom_google_font.dart';
import '../widgets/custom_seach_bar.dart';
import 'found_recipes_details_screen.dart';

class SearchResipesScreen extends StatelessWidget {
  const SearchResipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedByTime =
        foundRecipes.where((time) => time.foodModel.cookTime >= 10);
    final displaySortedByTime = sortedByTime
        .map(
          (val) => FoundRecipes(
            foodModel: FoodModel(
              name: val.foodModel.name,
              cookTime: val.foodModel.cookTime,
              difficulty: val.foodModel.difficulty,
              numOfRating: val.foodModel.numOfRating,
              midRating: val.foodModel.midRating,
              image: val.foodModel.image,
            ),
          ),
        )
        .toList();
    final sortedByDifficulty =
        foundRecipes.where(((e) => e.foodModel.difficulty == 'Easy'));
    final displaySortedByDifficulty = sortedByDifficulty
        .map(
          (val) => FoundRecipes(
            foodModel: FoodModel(
              name: val.foodModel.name,
              cookTime: val.foodModel.cookTime,
              difficulty: val.foodModel.difficulty,
              numOfRating: val.foodModel.numOfRating,
              midRating: val.foodModel.midRating,
              image: val.foodModel.image,
            ),
          ),
        )
        .toList();
    final displayByDifficulty = sortedByDifficulty.map((val) {
      final values = val.foodModel.name;
      return Text(values);
    }).toList();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                    iconSize: 25,
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: CustomSearchBar(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: CustomHeadline(
                  titleOfHeadline: '207 Recipes',
                  seeAll: 'Filters',
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.red,
                    size: 22,
                  ),
                  onTap: () {},
                ),
              ),
              _buildFoundRecipeSlider(
                  foundRecipes: displaySortedByTime, size: size),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildFoundRecipeSlider extends StatelessWidget {
  const _buildFoundRecipeSlider({
    Key? key,
    required this.foundRecipes,
    required this.size,
  }) : super(key: key);

  final List<FoundRecipes> foundRecipes;
  final Size size;

  @override
  Widget build(BuildContext context) {
    var shufleRecipes = foundRecipes..shuffle();
    return Expanded(
      child: ListView.separated(
        itemCount: shufleRecipes.length,
        itemBuilder: (context, index) {
          var foundRecipes = shufleRecipes[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FoundRecipesDetailsScreen(
                    foundRecipes: foundRecipes,
                  ),
                ),
              );
            },
            child: _buildFoundRecipeCard(foundRecipes: foundRecipes),
          );
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding:
                EdgeInsets.fromLTRB((size.width / 6), 0, (size.width / 6), 0),
            child: Divider(
              height: 20,
              color: Colors.grey[300],
            ),
          );
        },
      ),
    );
  }
}

class _buildFoundRecipeCard extends StatelessWidget {
  const _buildFoundRecipeCard({
    Key? key,
    required this.foundRecipes,
  }) : super(key: key);

  final FoundRecipes foundRecipes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image(
                    image: AssetImage(
                      foundRecipes.foodModel.image,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFoundRecipeName(
                    foundRecipes: foundRecipes,
                  ),
                  _buildFoundRecipeRating(
                    foundRecipes: foundRecipes,
                  ),
                  _buildCookTimeAndDifficulty(
                    foundRecipes: foundRecipes,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _buildFoundRecipeName extends StatelessWidget {
  const _buildFoundRecipeName({
    Key? key,
    required this.foundRecipes,
  }) : super(key: key);

  final FoundRecipes foundRecipes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: CustomGoogleFontText(
        text: foundRecipes.foodModel.name,
        textStyle: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _buildFoundRecipeRating extends StatelessWidget {
  const _buildFoundRecipeRating({
    Key? key,
    required this.foundRecipes,
  }) : super(key: key);

  final FoundRecipes foundRecipes;

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
            text: foundRecipes.foodModel.midRating.toString(),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          CustomGoogleFontText(
            text: '(${foundRecipes.foodModel.numOfRating} ratings)',
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

class _buildCookTimeAndDifficulty extends StatelessWidget {
  const _buildCookTimeAndDifficulty({
    Key? key,
    required this.foundRecipes,
  }) : super(key: key);

  final FoundRecipes foundRecipes;

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
                text: '${foundRecipes.foodModel.cookTime} mins',
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
                text: foundRecipes.foodModel.difficulty,
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
