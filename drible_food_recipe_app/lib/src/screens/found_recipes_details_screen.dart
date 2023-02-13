import 'package:drible_food_recipe_app/src/models/found_recipes.dart';
import 'package:drible_food_recipe_app/src/widgets/custom_google_font.dart';
import 'package:flutter/material.dart';

class FoundRecipesDetailsScreen extends StatelessWidget {
  final FoundRecipes foundRecipes;
  const FoundRecipesDetailsScreen({
    Key? key,
    required this.foundRecipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomGoogleFontText(
                text: foundRecipes.foodModel.name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
