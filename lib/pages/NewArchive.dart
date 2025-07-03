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
    final uri = Uri.parse('http://172.16.12.86:3000/licenses/archives');
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
Color _getCardColor(String expiryDateStr) {
    DateTime expiryDate;

    try {
      expiryDate = DateTime.parse(expiryDateStr);
    } catch (e) {
      // If parsing fails, fallback to amber color
      return Colors.amber;
    }

   final now = DateTime.now();
final diff = expiryDate.difference(now);
final diffDays = (diff.inMilliseconds / (1000 * 60 * 60 * 24)).ceil();


    if (diffDays <= 0) {
      return Colors.red; // Expired
    } else if (diffDays <= 30) {
      return Colors.red.shade900; // Urgent to renew (dark red)
    } else if (diffDays <= 200) {
      return Colors.orange; // Expiring soon
    } else {
      return Colors.green; // Valid
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
        leading: Builder(builder: (context)=>IconButton(onPressed: (){
          Scaffold.of(context).openDrawer();
        }, icon: Icon(Icons.menu))),
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
                final color = _getCardColor(lic['expiryDate']);
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                    ),
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
