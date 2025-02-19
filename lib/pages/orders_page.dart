import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/componentes/order.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/componentes/app_drawer.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Pedidos')),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, i) => OrderWidget(
          order: orders.items[i],
        ),
      ),
    );
  }
}
