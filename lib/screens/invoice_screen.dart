import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/invoice.dart';
import '../utils/gst_calculation.dart';

class InvoiceScreen extends StatelessWidget {
  final Invoice invoice;
  const InvoiceScreen({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = invoice.products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
        centerTitle: true,
      ),
      body: products.isEmpty
          ? const Center(child: Text('No products to invoice.'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Itemized Invoice',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Expanded(flex: 2, child: Text('Product Name', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text('GST Rate', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text('CGST', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text('SGST', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final p = products[index];
                        final cgst = calculateCGST(p.price, p.gstRate);
                        final sgst = calculateSGST(p.price, p.gstRate);
                        final total = calculateTotalPrice(p.price, p.gstRate);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: Text(p.name)),
                              Expanded(child: Text('₹${p.price.toStringAsFixed(2)}')),
                              Expanded(child: Text('${p.gstRate}%')),
                              Expanded(child: Text('₹${cgst.toStringAsFixed(2)}')),
                              Expanded(child: Text('₹${sgst.toStringAsFixed(2)}')),
                              Expanded(child: Text('₹${total.toStringAsFixed(2)}')),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(thickness: 2),
                  _buildTotalRow('Subtotal', invoice.subtotal),
                  _buildTotalRow('Total CGST', invoice.totalCGST),
                  _buildTotalRow('Total SGST', invoice.totalSGST),
                  const Divider(thickness: 2),
                  _buildTotalRow('Grand Total', invoice.grandTotal, isBold: true),
                  const SizedBox(height: 24),
                  // Optional: Export button placeholder
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement export to PDF/CSV
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Export feature coming soon!')),
                        );
                      },
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text('Export Invoice'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTotalRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal))),
          Expanded(child: Container()),
          Expanded(child: Container()),
          Expanded(child: Container()),
          Expanded(child: Container()),
          Expanded(child: Text('₹${value.toStringAsFixed(2)}', style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal))),
        ],
      ),
    );
  }
}
