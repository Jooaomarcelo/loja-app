import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_routes.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  void _selectProduct(BuildContext context, Product product) {
    Navigator.of(context).pushNamed(
      AppRoutes.PRODUCT_DETAIL,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
      // Por padrão. Caso a APP não necessite atualizar o UI definir como 'false'.
      // Aqui foi utilizado o 'false' porque mais abaixo utilizamos o componente
      // 'Consumer' (definimos exatamente o que necessita de atualizações).
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () => _selectProduct(context, product),
        splashColor: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                // O 3º parâmetro é destinado ao 'child' (um componente que não sofre modificação caso fosse necessário).
                onPressed: () => product.toggleFavorite(),
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
