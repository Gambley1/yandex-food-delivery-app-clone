import 'package:drible_food_recipe_app/src/models/food_model.dart';

class FoundRecipes {
  final FoodModel foodModel;

  FoundRecipes({
    required this.foodModel,
  });
}

List<FoundRecipes> foundRecipes = [
  FoundRecipes(
    foodModel: FoodModel(
      name: 'Grilled Salmon',
      midRating: 4.6,
      image: 'assets/food/grilled_salmon.jpg',
      numOfRating: 2203,
      cookTime: 45,
      difficulty: 'Moderate',
    ),
  ),
  FoundRecipes(
    foodModel: FoodModel(
      name: 'Chicken Breat',
      midRating: 4.8,
      image: 'assets/food/chicken_breat.png',
      numOfRating: 1517,
      cookTime: 30,
      difficulty: 'Easy',
    ),
  ),
  FoundRecipes(
    foodModel: FoodModel(
      name: 'Delicios Waffles',
      cookTime: 20,
      difficulty: 'Easy',
      numOfRating: 4213,
      midRating: 4.9,
      image: 'assets/food/delicious_waffles.png',
    ),
  ),
];
