import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/componentes/order.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/componentes/app_drawer.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

   Future<void> _refreshOrders(BuildContext context) {
    return Provider.of<OrderList>(context, listen: false).loadOrders();
  }

  @override
  void initState(){
    super.initState();
    Provider.of<OrderList>(listen: false, context).loadOrders().then((_) {
      setState(() => _isLoading = false);
    });

  }
  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Pedidos')),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshOrders(context),
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            if (_isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (orders.itemsCount == 0) {
              return const Center(
                child: Text(
                  'Nenhum pedido encontrado!',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (ctx, i) => OrderWidget(
                  order: orders.items[i],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
