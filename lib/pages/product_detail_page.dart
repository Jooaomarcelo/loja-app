import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_detail_carousel.dart';
import 'package:shop/models/cart.dart';

import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ProductDetailCarousel(product),
                const SizedBox(height: 10),
                Text(
                  'R\$ ${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    product.description,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          // Adicionando os botões na parte inferior
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Produto adicionado com sucesso!'),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'DESFAZER',
                          textColor: Theme.of(context).colorScheme.error,
                          onPressed: () => cart.removeItemQuantity(product.id),
                        ),
                      ),
                    );
                    cart.addItem(product);
                  },
                  child: const Text(
                    'Adicionar ao Carrinho',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Redireciona para a página do carrinho
                    Navigator.of(context).pushNamed('/cart');
                  },
                  child: const Text(
                    'Finalizar Compra',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
