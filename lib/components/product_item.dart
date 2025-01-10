import 'package:flutter/material.dart';
import '../utils/app_routes.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    required this.product,
    super.key,
  });

  void _selectProduct(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.PRODUCT_DETAIL,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () => _selectProduct(context),
        splashColor: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                product.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.secondary,
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
