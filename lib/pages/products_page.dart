import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_list.dart';

import '../components/app_drawer.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Produtos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (ctx, i) => Text(products.items[i].name),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
