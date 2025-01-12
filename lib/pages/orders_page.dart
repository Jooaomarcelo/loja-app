import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/order_item.dart';
import 'package:shop/models/order_list.dart';

import '../components/app_drawer.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, i) => OrderItem(
          order: orders.items[i],
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
