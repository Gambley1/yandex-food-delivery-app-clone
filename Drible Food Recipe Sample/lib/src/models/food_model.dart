class FoodModel {
  final String name;
  final int cookTime;
  final String difficulty;
  final String image;
  final int numOfRating;
  final double midRating;

  FoodModel({
    required this.name,
    required this.cookTime,
    required this.difficulty,
    required this.numOfRating,
    required this.midRating,
    required this.image,
  });
}

List<FoodModel> foodModel = [
  FoodModel(
    name: 'Grilled Salmon',
    midRating: 4.9,
    image: 'assets/food/grilled_salmon.jpg',
    numOfRating: 2203,
    cookTime: 45,
    difficulty: 'Moderate',
  ),
  FoodModel(
    name: 'Chicken Breat',
    midRating: 4.8,
    image: 'assets/food/chicken_breat.png',
    numOfRating: 1517,
    cookTime: 30,
    difficulty: 'Easy',
  ),
  FoodModel(
    name: 'Delicios Waffles',
    cookTime: 20,
    difficulty: 'Easy',
    numOfRating: 4213,
    midRating: 4.6,
    image: 'assets/food/delicious_waffles.png',
  ),
];
