import 'package:flutter/material.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first

class Product with ChangeNotifier{
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

//método para alterar se o produto é favorito ou não.
  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

