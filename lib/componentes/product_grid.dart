import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/componentes/product_item.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount:
          loadedProducts.length, //Pega a quantidade de itens dentro da lista.
      //value é utilizado pois está utilizando os elementos que já foram criados anteriormente no Main.
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value (
        value: loadedProducts[i],
        child: const ProductItem(),
      ),
      //Define uma estrutura de grid, exibindo 2 elementos na tela.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
