import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;

  const OrderWidget({super.key, required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          _expanded ? Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            height: (widget.order.products.length * 24) + 10,
            child: 
                ListView(
                    children: widget.order.products.map((product) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${product.quantity} x R\$ ${product.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  )             
          ) : Container()
        //   Container(
        //     child: _expanded
        //         ? Column(
        //             children: widget.order.products.map((product) {
        //               return ListTile(
        //                 title: Text(product.name,
        //                     style: const TextStyle(
        //                       fontSize: 18,
        //                       fontWeight: FontWeight.bold,
        //                     )),
        //                 subtitle: Text(
        //                     '${product.quantity} x R\$ ${product.price}', 
        //                     style: const TextStyle(
        //                       fontSize: 16,
        //                       color: Colors.grey,
        //                     )),
        //               );
        //             }).toList(),
        //           )
        //         : null,
        //   )
        // ],
        
        ],
      ),
    );
  }
}