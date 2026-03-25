import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';
import 'config/routes.dart';

void main() async {
  // Initialize Hive Database
  await Hive.initFlutter();
  
  runApp(
    MultiProvider(
      providers: [
        // Add providers here
        // Example: ChangeNotifierProvider(create: (_) => BillingProvider()),
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
      home: const HomeScreen(),
      routes: AppRoutes.routes,
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
