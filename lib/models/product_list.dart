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

  void updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  void saveProduct(Map<String, Object> data) {
    final hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imagesUrl: data['imagesUrl'] as List<String>,
    );

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }
}
