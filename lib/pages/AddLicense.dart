import 'package:check_license/Component/Drawer.dart';
import 'package:check_license/models/DataBsaeLicense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Addlicense extends StatefulWidget {
  const Addlicense({super.key});

  @override
  State<Addlicense> createState() => _AddlicenseState();
}

class _AddlicenseState extends State<Addlicense> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameControllor= TextEditingController();
  String _softwareName = '';
  DateTime? _expiryDate;
  DateTime? startDate;
  

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Submit logic here
      Provider.of<Databsaelicense>(context,listen: false)..addItem('', 'assets/img/Zoom-Logo-PNG-Clipart.png', nameControllor.text, startDate!, _expiryDate!);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('License submitted successfully')));
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
    initialDate: startDate ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (picked != null && picked != startDate) {
    setState(() {
      startDate = picked;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New License')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              /// Software Name
              TextField(
                decoration: InputDecoration(
                  labelText: 'Software Name',
                  border: OutlineInputBorder(),
                ),
                controller: nameControllor,
              ),
              
              SizedBox(height: 16),

              /// Responsible Person Email
              SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDateStart(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    startDate == null
                        ? 'Select date'
                        : '${startDate!.toLocal()}'.split(' ')[0],
                    style: TextStyle(
                      color: startDate == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              /// Expiry Date Picker
              InkWell(
                onTap: () => _selectDateFin(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Expiry Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _expiryDate == null
                        ? 'Select date'
                        : '${_expiryDate!.toLocal()}'.split(' ')[0],
                    style: TextStyle(
                      color: _expiryDate == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              /// Submit Button
              ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text('Submit'),
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
