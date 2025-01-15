import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/data/dummy_products.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  void addProduct(Product product) {

    _items.add(product);
    //notifica os interessados(pais/filhos).
    notifyListeners();
  }
}