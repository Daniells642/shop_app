import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/componentes/badges.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/componentes/app_drawer.dart';
import 'package:shop/componentes/product_grid.dart';

// ignore_for_file: file_names

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minha Loja"),
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text("Somente Favoritos"),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text("Todos"),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              // ignore: avoid_print
              if (selectedValue == FilterOptions.favorite) {
                provider.showFavoriteOnly();
              } else {
                provider.showAll();
              }
            }
            //print(selectedValue);
            ,
          ),
          Consumer<Cart>(
            builder: (ctx, cart, child) => Badges(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
          )
        ],
        //backgroundColor: Colors.blue,
      ),
      body: const ProductGrid(),
      drawer: const AppDrawer(),
    );
  }
}
