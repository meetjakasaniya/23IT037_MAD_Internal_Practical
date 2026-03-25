import 'package:hive/hive.dart';
part 'product.g.dart';

/// Product model for GST Billing App
/// Stores product name, price, and GST rate.
@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double price;
  @HiveField(2)
  final double gstRate; // GST rate as a percentage (e.g., 5, 12, 18, 28)

  Product({
    required this.name,
    required this.price,
    required this.gstRate,
  });
}
