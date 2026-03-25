import 'product.dart';

/// Invoice model to hold the list of products and GST breakdowns
class Invoice {
  final List<Product> products;

  Invoice({required this.products});

  double get subtotal =>
      products.fold(0.0, (sum, p) => sum + p.price);

  double get totalCGST =>
      products.fold(0.0, (sum, p) => sum + ((p.price * p.gstRate / 100) / 2));

  double get totalSGST =>
      products.fold(0.0, (sum, p) => sum + ((p.price * p.gstRate / 100) / 2));

  double get grandTotal => subtotal + totalCGST + totalSGST;
}
