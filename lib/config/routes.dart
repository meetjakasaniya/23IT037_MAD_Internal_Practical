import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/history_screen.dart';
import '../models/invoice.dart';
import '../screens/invoice_screen.dart';

class AppRoutes {
  // Route names
  static const String home = '/';
  static const String invoice = '/invoice';
  static const String history = '/history';

  // Routes map for navigation
  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    history: (context) => const HistoryScreen(),
  };
}
