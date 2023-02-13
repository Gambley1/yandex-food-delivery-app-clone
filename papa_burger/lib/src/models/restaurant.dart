// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:papa_burger/src/restaurant.dart';

class Restaurant {
  final String name;
  final int id;
  final List<Tag> tags;
  final List<Menu> menu;

  Restaurant({
    required this.name,
    required this.id,
    required this.tags,
    required this.menu,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'tags': tags,
      'menu': menu,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      name: map['name'] != null ? map['mame'] as String : '',
      id: map['id'] != null ? map['id'] as int : 0,
      tags: map['tags'] != null
          ? List<Tag>.from(
              (map['tags']).map<Tag>(
                (x) => Tag.fromMap(x),
              ),
            )
          : [],
      menu: map['items'] != null
          ? List<Menu>.from(
              (map['items']).map<Menu>(
                (x) => Menu.fromMap(x),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      Restaurant.fromMap(json);
}

class Tag {
  final String name;

  Tag({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(Map<String, dynamic> json) => Tag.fromMap(json);
}
