import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final _url =
      'https://shop-teste-ddc6e-default-rtdb.firebaseio.com/products.json';
  final List<Product> _items = [];
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

  //Obtendo produtos do backend com o metodo GET.
  Future<void> loadProducts() async {
    final response = await http.get(Uri.parse(_url));
    if (response.body == 'null') {
      return;
    }
    //print(json.decode(response.body));
    Map<String, dynamic> data = json.decode(response.body);
    _items.clear();
    data.forEach((productId, productData) {
      _items.add(Product(
        id: productId,
        name: productData['name'],
        price: productData['price'],
        description: productData['description'],
        imageUrl: productData['imageUrl'],
        isFavorite: productData['isFavorite'],
      ));
    });
    notifyListeners();
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      price: data['price'] as double,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updateProduct(newProduct);
    } else {
      return addProduct(newProduct);
    }
  }

  //Adicionar produtos
  //Metodos assincronos retornam um Future
  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse(_url),
      body: jsonEncode({
        'name': product.name,
        'price': product.price,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite,
      }),
    );
    final id = json.decode(response.body)['name'];
    _items.add(Product(
      id: id,
      name: product.name,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));
    notifyListeners();
  }

  //
  //
  // .catchError((error) {
  //   print(error.toString());
  //   throw error;
  // });

//Editar produtos
  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
    return Future.value();
  }

  void removeProduct(Product product) {
    _items.removeWhere((prod) => prod.id == product.id);
    notifyListeners();
  }
}
