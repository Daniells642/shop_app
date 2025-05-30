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

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    Provider.of<ProductList>(context, listen: false)
        .loadProducts()
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

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
              if (selectedValue == FilterOptions.favorite) {
                provider.showFavoriteOnly();
              } else {
                provider.showAll();
              }
            },
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
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (ctx, constraints) {
                // Ajusta o número de colunas com base na largura da tela
                final crossAxisCount = constraints.maxWidth > 1200
                    ? 6 // Para telas muito grandes
                    : constraints.maxWidth > 800
                        ? 4 // Para telas médias
                        : 2; // Para telas menores

                return ProductGrid(crossAxisCount: crossAxisCount);
              },
            ),
      drawer: const AppDrawer(),
    );
  }
}
