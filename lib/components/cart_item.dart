import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';

import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        padding: const EdgeInsets.only(right: 10),
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      onDismissed: (_) => Provider.of<Cart>(
        context,
        listen: false,
      ).removeItem(item.productId),
      child: Card(
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
            trailing: Consumer<Cart>(
              builder: (ctx, cart, child) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${item.quantity}x'),
                  IconButton(
                    onPressed: () => cart.removeItemQuantity(item.productId),
                    icon: Icon(
                      Icons.remove,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
