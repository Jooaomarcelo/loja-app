import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ListTile(
          title: Text(item.name),
          subtitle: Text(
              'Total: R\$${(item.price * item.quantity).toStringAsFixed(2)}'),
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('${item.price}'),
              ),
            ),
          ),
          trailing: Text('${item.quantity}x'),
        ),
      ),
    );
  }
}
