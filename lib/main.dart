import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';
import 'config/routes.dart';
import 'models/product.dart';
import 'utils/gst_calculation.dart';
import 'providers/cart_provider.dart';
import 'screens/billing_screen.dart';

void main() async {
  // Initialize Hive Database
  await Hive.initFlutter();
  
  // Example usage of Product model and GST calculation logic
  final products = [
    Product(name: 'Notebook', price: 100.0, gstRate: 12),
    Product(name: 'Pen', price: 20.0, gstRate: 5),
    Product(name: 'Backpack', price: 500.0, gstRate: 18),
    Product(name: 'Luxury Watch', price: 10000.0, gstRate: 28),
  ];

  for (var product in products) {
    final cgst = calculateCGST(product.price, product.gstRate);
    final sgst = calculateSGST(product.price, product.gstRate);
    final total = calculateTotalPrice(product.price, product.gstRate);
    print('Product: ${product.name}');
    print('  Price: ₹${product.price.toStringAsFixed(2)}');
    print('  GST Rate: ${product.gstRate}%');
    print('  CGST: ₹${cgst.toStringAsFixed(2)}');
    print('  SGST: ₹${sgst.toStringAsFixed(2)}');
    print('  Total Price: ₹${total.toStringAsFixed(2)}');
    print('---');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const GSTBillingApp(),
    ),
  );
}

class GSTBillingApp extends StatelessWidget {
  const GSTBillingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GST Billing App',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const BillingScreen(),
      // Remove the routes property or ensure it does NOT contain '/'
      // routes: AppRoutes.routes, // <-- REMOVE or comment this line
    );
  }
}

// Placeholder screen - will be replaced by actual HomeScreen
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GST Billing App'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Billing Screen'),
      ),
    );
  }
}
