import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _searchQuery = '';
  // Dummy invoice data for demonstration
  final List<Map<String, dynamic>> _invoices = [
    {'id': 'INV001', 'date': '2024-03-25', 'total': 1200.0},
    {'id': 'INV002', 'date': '2024-03-24', 'total': 800.0},
    {'id': 'INV003', 'date': '2024-03-23', 'total': 1500.0},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredInvoices = _invoices.where((invoice) {
      final query = _searchQuery.toLowerCase();
      return invoice['id'].toLowerCase().contains(query) ||
          invoice['date'].toLowerCase().contains(query);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search by Invoice ID or Date',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                      onChanged: (value) => setState(() => _searchQuery = value),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => _searchQuery = ''),
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredInvoices.isEmpty
                  ? const Center(child: Text('No invoices found.'))
                  : ListView.separated(
                      itemCount: filteredInvoices.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final invoice = filteredInvoices[index];
                        return ListTile(
                          leading: const Icon(Icons.receipt_long),
                          title: Text('Invoice #${invoice['id']}'),
                          subtitle: Text('Date: ${invoice['date']}'),
                          trailing: Text('₹${invoice['total']}'),
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
