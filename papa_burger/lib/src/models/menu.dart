import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'menu.g.dart';

class Menu {
  // final String imageName;
  final String categorie;
  final List<Item> items;
  final String description;

  Menu({
    required this.categorie,
    // required this.imageName,
    required this.items,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': categorie,
      'items': items.map((x) => x.toMap()).toList(),
      'description': description,
    };
  }

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      categorie: map['categorie'] as String,
      description: map['description'] as String,
      items: List<Item>.from(
        (map['items']).map<Item>(
          (x) => Item.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Menu.fromJson(Map<String, dynamic> json) => Menu.fromMap(json);
}

@HiveType(typeId: 0)
class Item extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final int price;
  @HiveField(3)
  final String? imgName;
  const Item({
    required this.name,
    required this.description,
    required this.price,
    this.imgName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'imgName': imgName,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      imgName: map['imgName'] != null ? map['imgName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(Map<String, dynamic> json) => Item.fromMap(json);

  String get getMenuItemsPrice => '${price.toStringAsFixed(2)}\$';
  String get getMenuItemsImagePathPng => 'assets/images/$name.png';

  @override
  List<Object?> get props => [
        name,
        description,
        price,
        imgName,
      ];
}
