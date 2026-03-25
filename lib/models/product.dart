/// Product model for GST Billing App
/// Stores product name, price, and GST rate.
class Product {
  final String name;
  final double price;
  final double gstRate; // GST rate as a percentage (e.g., 5, 12, 18, 28)

  Product({
    required this.name,
    required this.price,
    required this.gstRate,
  });
}
