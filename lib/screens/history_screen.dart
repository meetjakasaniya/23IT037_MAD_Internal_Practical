import 'package:flutter/material.dart';

/// Placeholder for History Screen
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('History Screen'),
      ),
    );
  }
}
