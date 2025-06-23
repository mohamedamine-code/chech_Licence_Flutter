import 'dart:io';

import 'package:check_license/Component/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';



class AddLicenseScreen extends StatefulWidget {
  @override
  _AddLicenseScreenState createState() => _AddLicenseScreenState();
}

class _AddLicenseScreenState extends State<AddLicenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  DateTime? _selectedDate;
  bool _loading = false;

  File? _selectedImage;
  String _softwareName = '';
  DateTime? _expiryDate;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      setState(() => _loading = true);

      final fcmToken = await FirebaseMessaging.instance.getToken();
      final expiryDate = _expiryDate!.toIso8601String().split('T').first;
      final selectedDate = _selectedDate!.toIso8601String().split('T').first;

      final uri = Uri.parse('http://192.168.0.56:3000/add-license',); // Replace with your server IP

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _nameController.text,
          'selectedDate': selectedDate,
          'expiryDate': expiryDate,
          'fcmToken': fcmToken,
        }),
      );

      setState(() => _loading = false);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('✅ License added')));
        _nameController.clear();
        _selectedDate = null;
        setState(() {});
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('❌ Failed: ${response.body}')));
        print('❌ Failed: ${response.body}');
      }
    }
  }






  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDateFin(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _expiryDate) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  Future<void> _selectDateStart(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Add New License')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
              children: [
                /// Software Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'License Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Software Name',
                        border: OutlineInputBorder(),
                      ),
                      controller: _nameController,
                    ),
            
                    SizedBox(height: 16),
                    //start date
                    Text(
                      'Start Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 10),

                    InkWell(
                      onTap: () => _selectDateStart(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          hintText: 'Start Date',
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _selectedDate == null
                              ? 'Select date'
                              : '${_selectedDate!.toLocal()}'.split(' ')[0],
                          style: TextStyle(
                            color: _selectedDate == null ? Colors.grey : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
            
                    /// Expiry Date Picker
                    Text(
                      'Expiry Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () => _selectDateFin(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          hintText: 'Expiry Date',
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _expiryDate == null
                              ? 'Select date'
                              : '${_expiryDate!.toLocal()}'.split(' ')[0],
                          style: TextStyle(
                            color:
                                _expiryDate == null ? Colors.grey : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
            
                    // pick image
                    Text(
                      'License Logo',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                            _selectedImage != null
                                ? Image.file(_selectedImage!, fit: BoxFit.cover)
                                : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_a_photo,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        'Tap to add image',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
            
                /// Submit Button
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.save, color: Colors.black),
                    label: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed:
                        (_nameController.text.isNotEmpty &&
                                _selectedDate != null &&
                                _expiryDate != null &&
                                _selectedImage != null)
                            ? _submitForm
                            : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}
