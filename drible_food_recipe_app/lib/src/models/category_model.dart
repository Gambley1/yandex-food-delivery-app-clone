import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String numOfRecipies;
  final Color backgroundColor;
  final String image;
  final double scale;

  CategoryModel({
    required this.name,
    required this.numOfRecipies,
    required this.backgroundColor,
    required this.image,
    required this.scale,
  });
}

List<CategoryModel> categoryModel = [
  CategoryModel(
    name: 'Appetizer',
    numOfRecipies: '79 recipes',
    backgroundColor: Colors.blue[100]!,
    image: 'assets/categories/plate1.png',
    scale: 8,
  ),
  CategoryModel(
    name: 'Breakfast',
    numOfRecipies: '102 recipes',
    backgroundColor: Colors.yellow[100]!,
    image: 'assets/categories/plate2.png',
    scale: 6,
  ),
  CategoryModel(
    name: 'Brunch',
    numOfRecipies: '45 recipes',
    backgroundColor: Colors.green[200]!,
    image: 'assets/categories/plate3.png',
    scale: 4,
  ),
];
