// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:papa_burger/src/restaurant.dart';

// class Item {
//   final String name;
//   final int id;
//   final double price;
//   final String description;
//   final Categorie categorie;

//   Item({
//     required this.name,
//     required this.id,
//     required this.price,
//     required this.description,
//     required this.categorie,
//   });

//   String get imagePathPng => 'assets/images/$name.png';
//   String get imagePathJpg => 'assets/images/$name.jpg';
//   String get priceString => '\$${price.toStringAsFixed(2)}';

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'name': name,
//       'id': id,
//       'price': price,
//       'description': description,
//       'categorie': categorie,
//     };
//   }

//   factory Item.fromMap(Map<String, dynamic> map) {
//     return Item(
//       name: map['name'] as String,
//       id: map['id'] as int,
//       price: map['price'] as double,
//       description: map['description'] as String,
//       categorie: Categorie.fromJson(map),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item.fromMap(json);
//   }
// }
