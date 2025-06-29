import 'dart:convert';

import 'package:check_license/Component/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArchiveGridPage extends StatefulWidget {
  @override
  _ArchiveGridPageState createState() => _ArchiveGridPageState();
}

class _ArchiveGridPageState extends State<ArchiveGridPage> {
  List<dynamic> _archived = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchArchivedLicenses();
  }

  Future<void> fetchArchivedLicenses() async {
    final uri = Uri.parse('http://192.168.1.22:3000/licenses/archives');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        setState(() {
          _archived = jsonDecode(response.body);
          _loading = false;
        });
      } else {
        setState(() => _loading = false);
        debugPrint('❌ Archive fetch failed: ${response.body}');
      }
    } catch (e) {
      setState(() => _loading = false);
      debugPrint('🚨 Network error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('Archived Licenses'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3 / 2,
              ),
              itemCount: _archived.length,
              itemBuilder: (context, index) {
                final lic = _archived[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          lic['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text("Expiry: ${lic['expiryDate']}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
