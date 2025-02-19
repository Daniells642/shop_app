import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/models/product_list.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(

                  AppRoutes.PRODUCT_FORM,
                  arguments: product,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Tem certeza?'),
                    content: const Text('Quer remover o produto?'),
                    actions: [
                      TextButton(
                        onPressed: () {

                          Navigator.of(ctx).pop(true);
                        },
                        child: const Text('Sim'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: const Text('Não'),

                      ),
                    ],
                  ),
                ).then((value) {
                  if (value ?? false) {

                    // ignore: use_build_context_synchronously
                    Provider.of<ProductList>(context, listen: false)
                        .removeProduct(product);
                  }
                });

                // showDialog(
                //   context: context,
                //   builder: (ctx) => AlertDialog(
                //     title: const Text('Tem certeza?'),
                //     content: const Text('Quer remover o produto?'),
                //     actions: [
                //       TextButton(
                //         onPressed: () {
                //           Navigator.of(ctx).pop(false);
                //         },
                //         child: const Text('Não'),
                //       ),
                //       TextButton(
                //         onPressed: () {
                //           Navigator.of(ctx).pop(true);
                //           Provider.of<ProductList>(context, listen: false)
                //               .removeProduct(product);
                //         },
                //         child: const Text('Sim'),
                //       ),
                //     ],
                //   ),
                // );
                // Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
