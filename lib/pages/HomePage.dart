import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(title: Text('Dashboard')),
  // drawer: MyDrawer(), // Your custom drawer
  body: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SummaryCard(title: 'Total Licenses', count: 15, color: Colors.blue),
            // SummaryCard(title: 'Expiring Soon', count: 3, color: Colors.red),
          ],
        ),
        SizedBox(height: 20),
        Text('Recent Licenses', style: TextStyle(fontSize: 18)),
        // Expanded(child: LicenseList()), // Recent 5 licenses
      ],
    ),
  ),
);
  }
}