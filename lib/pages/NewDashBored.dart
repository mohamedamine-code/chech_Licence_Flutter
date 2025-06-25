import 'dart:convert';
import 'package:check_license/Component/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<Map<String, dynamic>> fetchLicenseData() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.22:3000/licensesDash'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load licenses');
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    final numberStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchLicenseData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          final validList = data['validList'];
          final expiringSoon = data['expiringSoon'];
          final listExpired = data['listExpired'];
          final totalList = data['totalList'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              childAspectRatio: 6/7.8,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildCard(
                  title: 'Total Licenses',
                  count: totalList.length,
                  icon: Icons.pie_chart_outline,
                  color: Colors.blue,
                  titleStyle: titleStyle,
                  numberStyle: numberStyle,
                ),
                _buildCard(
                  title: 'Valid Licenses',
                  count: validList.length,
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                  titleStyle: titleStyle,
                  numberStyle: numberStyle,
                ),
                _buildCard(
                  title: 'Expiring Soon',
                  count: expiringSoon.length,
                  icon: Icons.hourglass_top,
                  color: Colors.orange,
                  titleStyle: titleStyle,
                  numberStyle: numberStyle,
                ),
                _buildCard(
                  title: 'Expired',
                  count: listExpired.length,
                  icon: Icons.cancel_outlined,
                  color: Colors.red,
                  titleStyle: titleStyle,
                  numberStyle: numberStyle,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required int count,
    required IconData icon,
    required Color color,
    required TextStyle titleStyle,
    required TextStyle numberStyle,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(title, style: titleStyle, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(count.toString(), style: numberStyle),
          ],
        ),
      ),
    );
  }
}
