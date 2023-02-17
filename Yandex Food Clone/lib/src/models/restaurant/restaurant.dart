import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:hive/hive.dart';
import 'package:papa_burger/src/restaurant.dart';

part 'restaurant.g.dart';

@immutable
@HiveType(typeId: 1)
class Restaurant extends Equatable {
  @HiveField(5)
  final String name;
  @HiveField(6)
  final String quality;
  @HiveField(7)
  final String imageUrl;
  @HiveField(8)
  final int id;
  @HiveField(9)
  final int numOfRatings;
  @HiveField(10)
  final double rating;
  @HiveField(11)
  final List<Tag> tags;
  @HiveField(12)
  final List<Menu> menu;

  const Restaurant({
    required this.name,
    required this.quality,
    required this.imageUrl,
    required this.id,
    required this.numOfRatings,
    required this.rating,
    required this.tags,
    required this.menu,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'image_url': imageUrl,
      'quality': quality,
      'rating': rating,
      'numOfRatings': numOfRatings,
      'tags': tags,
      'menu': menu,
    };
  }

  String toJson() => json.encode(toMap());

  const Restaurant.empty()
      : id = 0,
        imageUrl = '',
        name = '',
        quality = '',
        rating = 0,
        numOfRatings = 0,
        tags = const [],
        menu = const [];

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      quality: json['quality'],
      imageUrl: json['image_url'],
      id: json['id'],
      numOfRatings: json['num_of_ratings'],
      rating: json['rating'],
      tags: json['tags'] != null
          ? List<Tag>.from(
              (json['tags']).map<Tag>(
                (json) => Tag.fromJson(json),
              ),
            )
          : [],
      menu: json['menu'] != null
          ? List<Menu>.from(
              (json['menu']).map<Menu>(
                (json) => Menu.fromJson(json),
              ),
            )
          : [],
    );
  }

  String get qualityAndNumOfRatings => '$quality ($numOfRatings+) ';

  List<String> get tagsName => tags.map((e) => e.name).toList();

  String get tagsToString => '${tagsName.first}, ${tagsName.last}';

  @override
  List<Object?> get props => <Object?>[
        name,
        quality,
        imageUrl,
        id,
        numOfRatings,
        rating,
        tags,
        menu,
      ];
}

class Tag extends Equatable {
  final String name;

  const Tag({required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[name];
}
