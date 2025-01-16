import 'dart:math';

import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  // Retornando uma cópia de itens e não a referência
  List<Product> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favorites =>
      _items.where((item) => item.isFavorite).toList();

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void addProductFromData(Map<String, Object> data) {
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    _items.add(newProduct);
  }
}
