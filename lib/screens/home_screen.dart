import 'package:flutter/material.dart';

import '../config/app_theme.dart';

/// HomeScreen displays the main billing interface for the GST Billing App.
/// This is a placeholder screen for the initial setup.
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
        child: Text(
          'Billing Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
