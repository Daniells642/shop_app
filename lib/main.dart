import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/products_overview_page.dart';

void main() {
  runApp(const MyApp());
}
  
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          //fontFamily: 'Lato',
          //primarySwatch: Colors.purple,
          // colorScheme: ColorScheme.fromSwatch().copyWith(
          //   secondary: Colors.blue,
          // ),

          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple, // Cor padrão para todas as AppBars
            titleTextStyle: TextStyle(
              color: Colors.white, // Cor do texto
              fontSize: 20, // Tamanho da fonte
              fontWeight: FontWeight.bold,
            ),
            centerTitle: true,
          ),
        ),
        debugShowCheckedModeBanner: false,
        //home: const ProductsOverviewPage(),
        routes: {
          AppRoutes.HOME: (ctx) => const ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.CART: (ctx) =>  const CartPage(),
          AppRoutes.ORDERS: (ctx) =>  const OrdersPage(),
        },
      ),
    );
  }
}
