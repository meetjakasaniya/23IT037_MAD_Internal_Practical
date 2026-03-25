import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../utils/gst_calculation.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  double? _selectedGstRate;

  final List<double> _gstRates = [5, 12, 18, 28];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _addProduct(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final price = double.parse(_priceController.text.trim());
      final gstRate = _selectedGstRate!;
      final product = Product(name: name, price: price, gstRate: gstRate);
      Provider.of<CartProvider>(context, listen: false).addProduct(product);
      _nameController.clear();
      _priceController.clear();
      setState(() => _selectedGstRate = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('GST Billing App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null || value.trim().isEmpty ? 'Enter product name' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Product Price',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Enter price';
                      final price = double.tryParse(value.trim());
                      if (price == null || price < 0) return 'Enter valid price';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<double>(
                    value: _selectedGstRate,
                    items: _gstRates
                        .map((rate) => DropdownMenuItem(
                              value: rate,
                              child: Text('$rate%'),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _selectedGstRate = value),
                    decoration: const InputDecoration(
                      labelText: 'GST Rate',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null ? 'Select GST rate' : null,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _addProduct(context),
                      child: const Text('Add Product'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Cart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: cart.products.isEmpty
                  ? const Center(child: Text('No products in cart.'))
                  : ListView.separated(
                      itemCount: cart.products.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final product = cart.products[index];
                        final cgst = calculateCGST(product.price, product.gstRate);
                        final sgst = calculateSGST(product.price, product.gstRate);
                        final total = calculateTotalPrice(product.price, product.gstRate);
                        return Dismissible(
                          key: ValueKey(product.name + product.price.toString() + product.gstRate.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (_) => cart.removeProduct(index),
                          child: ListTile(
                            title: Text(product.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Price: ₹${product.price.toStringAsFixed(2)}'),
                                Text('GST Rate: ${product.gstRate}%'),
                                Text('CGST: ₹${cgst.toStringAsFixed(2)}  |  SGST: ₹${sgst.toStringAsFixed(2)}'),
                                Text('Total: ₹${total.toStringAsFixed(2)}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => cart.removeProduct(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
