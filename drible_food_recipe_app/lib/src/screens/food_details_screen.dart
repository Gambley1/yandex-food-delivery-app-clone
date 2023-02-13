import 'package:drible_food_recipe_app/src/models/food_model.dart';
import 'package:drible_food_recipe_app/src/widgets/custom_google_font.dart';
import 'package:flutter/material.dart';

class FoodDetailsScreen extends StatelessWidget {
  final FoodModel foodModel;
  const FoodDetailsScreen({
    Key? key,
    required this.foodModel,
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
                text: foodModel.name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
