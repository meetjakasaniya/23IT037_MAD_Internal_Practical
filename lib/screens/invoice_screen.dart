import 'package:flutter/material.dart';

/// Placeholder for Invoice Screen
class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Invoice Screen'),
      ),
    );
  }
}
