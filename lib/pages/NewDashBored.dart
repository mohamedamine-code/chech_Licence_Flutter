import 'dart:convert';
import 'package:check_license/Component/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<Map<String, dynamic>> fetchLicenseData() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.22:3000/licensesDash'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)as Map<String, dynamic>; // ✅ ensure this cast
    } else {
      throw Exception('Failed to load licenses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashbored"),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchLicenseData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('errur:${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          final validList = data['validList'];
          final expiringSoon = data['expiringSoon'];
          final listExpired = data['listExpired'];
          final totalList = data['totalList'];

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('✅ Valid Licenses: ${validList.length}'),
                Text('⏳ Expiring Soon: ${expiringSoon.length}'),
                Text('❌ Expired: ${listExpired.length}'),
                Text('📊 Total: ${totalList.length}'),
                // Optionally display detailed lists here
              ],
            ),
          );
        },
      ),
    );
  }
}
