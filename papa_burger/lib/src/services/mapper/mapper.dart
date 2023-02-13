import 'package:papa_burger/src/restaurant.dart';

class Mapper {
  static restaurantFromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      tags: json['tags'] != null
          ? List<Tag>.from(
              (json['tags']).map<Tag>(
                (tag) => Tag.fromMap(tag),
              ),
            )
          : [],
      menu: json['menu'] != null
          ? List<Menu>.from(
              (json['menu']).map<Menu>(
                (menu) => Menu.fromMap(menu),
              ),
            )
          : [],
    );
  }
}
