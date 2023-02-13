import 'package:papa_burger/src/restaurant.dart';

class MockCategories {
  static final tags = [
    Tag(
      name: 'Burger',
    ),
    Tag(
      name: 'Soup',
    ),
    Tag(
      name: 'Pizza',
    ),
    Tag(
      name: 'Pasta',
    ),
    Tag(
      name: 'Ice Cream',
    ),
  ];

  List get getCategorie => tags;
}
