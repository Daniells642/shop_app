import 'package:flutter/material.dart';
import 'package:shop/pages/products_overViewPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green, // Cor padrão para todas as AppBars
          titleTextStyle: TextStyle(
            color: Colors.white, // Cor do texto
            fontSize: 20, // Tamanho da fonte
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
      ),
      home: ProductOverviewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
