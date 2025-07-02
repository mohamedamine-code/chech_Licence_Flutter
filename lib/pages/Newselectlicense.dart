import 'package:check_license/Component/Drawer.dart';
import 'package:check_license/pages/LicenseInformation.dart';
import 'package:check_license/util/printPdf.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LicenseGridPage extends StatefulWidget {
  @override
  _LicenseGridPageState createState() => _LicenseGridPageState();
}

class _LicenseGridPageState extends State<LicenseGridPage> {
  List<dynamic> _licenses = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchLicenses();
  }

  Future<void> fetchLicenses() async {
    final uri = Uri.parse(
      'http://192.168.1.22:3000/licenses',
    ); // ← Replace with your actual backend IP

    try {
      final response = await http.get(uri);
      print("🔗 Response code: ${response.statusCode}");
      print("📦 Raw body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("✅ Parsed data: $data");

        setState(() {
          _licenses = data;
          _loading = false;
        });
      } else {
        print("❌ Failed to fetch licenses: ${response.body}");
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      print("🚨 Error during fetch: $e");
      setState(() {
        _loading = false;
      });
    }
  }
  Future<void> archiveLicense(String id) async {
  final uri = Uri.parse('http://192.168.1.22:3000/licenses/archive/$id'); // Replace with your endpoint
  try {
    final response = await http.put(uri); // or .post() depending on backend
    if (response.statusCode == 200) {
      print("✅ License archived");
    } else {
      print("❌ Failed to archive: ${response.body}");
    }
  } catch (e) {
    print("🚨 Error archiving license: $e");
  }
}
Color _getCardColor(String expiryDateStr) {
    final now = DateTime.now();
    DateTime expiryDate;

    try {
      expiryDate = DateTime.parse(expiryDateStr);
    } catch (e) {
      // If parsing fails, fallback to amber color
      return Colors.amber;
    }

    final diffDays = expiryDate.difference(now).inDays;

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
      floatingActionButton: AnimatedOpacity(
        opacity: 0.5,
        duration: Duration(microseconds: 1),
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () {
            generatePdfReportAllLicense(_licenses);
          },
          child: Center(child: Icon(Icons.warning_rounded)),
        ),
      ),
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('All Licenses'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body:
          _loading
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 cards per row
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: _licenses.length,
                itemBuilder: (context, index) {
                  final license = _licenses[index];
                  final color = _getCardColor(license['expiryDate']);
                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Text("Archive License"),
                              content: Text(
                                "Do you want to move this license to archive?",
                              ),
                              actions: [
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: Text("Archive"),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await archiveLicense(
                                      license['_id'],
                                    ); // Call archive function
                                    setState(() {
                                      _licenses.removeAt(index); // Update UI
                                    });
                                  },
                                ),
                              ],
                            ),
                      );
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => LicenseInformation(
                                index: index,
                                state: "",
                                FinDate: license['expiryDate'],
                                name: license['name'],
                                StartDate: license['selectedDate'],
                              ),
                        ),
                      );
                    },
                    child: Card(
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
                              license['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text("Expiry: ${license['expiryDate']}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
