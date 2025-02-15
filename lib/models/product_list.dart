import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/data/dummy_products.dart';


class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;
  bool _showFavoriteOnly = false;

  List<Product> get items {
    if (_showFavoriteOnly) {
      return _items.where((prod) => prod.isFavorite).toList();
    }
    return [..._items];
  }

   int get itemsCount {
    return _items.length;
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

   void saveProductFromData(Map<String, Object> data ) {
    bool hasId = data ['id'] != null;
    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      price: data['price'] as double,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
       updateProduct(newProduct);
    } else {
      addProduct(newProduct);
    }
    //notifica os interessados(pais/filhos).
    addProduct(newProduct);
  }
   void addProduct(Product product) {
    _items.add(product);
    //notifica os interessados(pais/filhos).
    notifyListeners();
  }

  void updateProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }
    final index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }
}
