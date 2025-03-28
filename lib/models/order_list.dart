import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';
import 'package:shop/models/cart_item.dart';


class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    _items.clear();
    final response =
        await http.get(Uri.parse('${Constants.ORDER_BASE_URL}.json'));
    if (response.body == 'null') {
      return;
    }
    //print(json.decode(response.body));
    Map<String, dynamic> data = json.decode(response.body);
    
  data.forEach((orderId, orderData) {
    _items.add(Order(
      id: orderId,
      total: (orderData['total'] as num).toDouble(),
      date: DateTime.parse(orderData['date']),
      products: (orderData['products'] as List<dynamic>).map((item) {
        return CartItem(
          id: item['id'],
          productId: item['productId'],
          name: item['name'],
          quantity: item['quantity'] ,
          price: (item['price']as num).toDouble() ,
        );
      }).toList(),
    ));
  });
  notifyListeners();
  //print(data);
  }


  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await http. post(
      Uri.parse('${Constants.ORDER_BASE_URL}.json'),
      body: jsonEncode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products': cart.items.values.map((cartItem) => {
              'id': cartItem.id,
              'productId': cartItem.productId,
              'name': cartItem.name,
              'quantity': cartItem.quantity,
              'price': cartItem.price,
            }).toList()

      }),
    );
final id = json.decode(response.body)['name'];
    _items.insert(
        0,
        Order(
            id: id,
            total: cart.totalAmount,
            date: date,
            products: cart.items.values.toList(),
            ));

    notifyListeners();
  }
}

