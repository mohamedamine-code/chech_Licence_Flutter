import 'package:flutter/material.dart';

class LicenseListPage extends StatelessWidget {
  final String title;
  final List<dynamic> licenses;

  const LicenseListPage({super.key, required this.title, required this.licenses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepPurple,
      ),
      body: licenses.isEmpty
          ? const Center(child: Text("No licenses available"))
          : ListView.builder(
              itemCount: licenses.length,
              itemBuilder: (context, index) {
                final license = licenses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    leading: const Icon(Icons.badge, color: Colors.deepPurple),
                    title: Text(license['name'] ?? 'No Name'),
                    subtitle: Text('Expiry: ${license['expiryDate'] ?? 'Unknown'}'),
                  ),
                );
              },
            ),
    );
  }
}
