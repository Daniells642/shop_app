import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/data/dummy_products.dart';
import 'package:shop/componentes/product_item.dart';

class ProductsOverviewPage extends StatelessWidget {
  final List<Product> loadedProducts = dummyProducts;
  ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Loja"),
        //backgroundColor: Colors.blue,
        
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount:
            loadedProducts.length, //Pega a quantidade de itens dentro da lista.
        itemBuilder: (ctx, i) => ProductItem(product: loadedProducts[i]),
        //Define uma estrutura de grid, exibindo 2 elementos na tela.
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
