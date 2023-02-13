import 'package:flutter/material.dart';

class CategoriesModel {
  final String name;
  final Icon icon;
  final Color backgroundColor;

  CategoriesModel({
    required this.name,
    required this.icon,
    required this.backgroundColor,
  });
}

List<CategoriesModel> categoriesModel = [
  CategoriesModel(
    name: 'Electronic',
    icon: Icon(
      Icons.computer_rounded,
      size: 40,
      color: Colors.orange.withOpacity(0.5),
    ),
    backgroundColor: Colors.yellow.withOpacity(0.3),
  ),
  CategoriesModel(
    name: 'Furniture',
    icon: const Icon(
      Icons.weekend,
      size: 40,
    ),
    backgroundColor: Colors.green.withOpacity(0.3),
  ),
  CategoriesModel(
    name: 'Electronic',
    icon: Icon(
      Icons.computer_rounded,
      size: 40,
      color: Colors.orange.withOpacity(0.5),
    ),
    backgroundColor: Colors.yellow.withOpacity(0.3),
  ),
  CategoriesModel(
    name: 'Electronic',
    icon: Icon(
      Icons.computer_rounded,
      size: 40,
      color: Colors.orange.withOpacity(0.5),
    ),
    backgroundColor: Colors.yellow.withOpacity(0.3),
  ),
];
