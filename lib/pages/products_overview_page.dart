import 'package:flutter/material.dart';
import 'package:shop/componentes/product_grid.dart';

// ignore_for_file: file_names

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Loja"),
        //backgroundColor: Colors.blue,
      ),
      body: const ProductGrid(),
    );
  }
}
