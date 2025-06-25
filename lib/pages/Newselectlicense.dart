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
    final uri = Uri.parse('http://192.168.1.22:3000/licenses',); // ← Replace with your actual backend IP

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
      appBar: AppBar(title: Text('All Licenses'),
      backgroundColor: Colors.deepPurple,
      centerTitle: true,),
      body: _loading
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
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LicenseInformation(index: index, state: "", FinDate:license['expiryDate'] , name: license['name'], StartDate: license['selectedDate'])));
                  },
                  child: Card(
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
