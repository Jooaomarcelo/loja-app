import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int itemsCount() {
    return _items.length;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (currentItem) => CartItem(
          id: currentItem.id,
          productId: currentItem.productId,
          name: currentItem.name,
          quantity: currentItem.quantity + 1,
          price: currentItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeItemQuantity(String productId) {
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (currentItem) => CartItem(
                id: currentItem.id,
                productId: currentItem.productId,
                name: currentItem.name,
                quantity: currentItem.quantity - 1,
                price: currentItem.price,
              ));
    } else {
      removeItem(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  double get totalAmount {
    double totalAmount = _items.values
        .map((cartItem) => cartItem.price * cartItem.quantity)
        .reduce((sum, element) => sum + element);

    return totalAmount;
  }
}
