import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'menu.g.dart';

class Menu {
  final String categorie;
  final List<Item> items;

  Menu({
    required this.categorie,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': categorie,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      categorie: json['categorie'] as String,
      items: List<Item>.from(
        (json['items']).map<Item>(
          (x) => Item.fromJson(x),
        ),
      ),
    );
  }
}

@HiveType(typeId: 0)
class Item extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final double price;
  // @HiveField(4)
  // final double discount;
  const Item({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    // required this.discount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'price': price,
      // 'discount': discount,
    };
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      price: json['price'] ?? 0,
      // discount: json['discount'] ?? 0.0,
    );
  }

  String get getMenusItemsPriceString => '${price.toStringAsFixed(2)}\$';

  @override
  List<Object?> get props => [
        name,
        description,
        price,
        imageUrl,
      ];
}
