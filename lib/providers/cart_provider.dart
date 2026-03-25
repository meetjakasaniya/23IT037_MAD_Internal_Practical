import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => List.unmodifiable(_products);

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  double get totalCartValue {
    return _products.fold(0.0, (sum, product) =>
      sum + product.price * (1 + product.gstRate / 100));
  }

  void clearCart() {
    _products.clear();
    notifyListeners();
  }
}
