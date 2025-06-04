import 'package:check_license/models/license.dart';
import 'package:flutter/material.dart';

class Databsaelicense extends ChangeNotifier{
  // DateTime(year,month,day)
String StateLicense = '';


// Check the availability of the license by date
void checkDate(License x) {
  DateTime today = DateTime.now();
  if (x.StartDate.isBefore(today) && 
      (today.isBefore(x.FinDate) || today.isAtSameMomentAs(x.FinDate))) {
    
    Duration diff = x.FinDate.difference(today);

    if (diff.inDays < 7) {
      StateLicense = 'Less than 1 week remaining';
    } else if (diff.inDays < 14) {
      StateLicense = 'Less than 2 weeks remaining';
    } else if (diff.inDays < 30) {
      StateLicense = 'Less than 1 month remaining';
    } else {
      StateLicense = 'License is valid for more than 1 month';
    }

  } else {
    StateLicense = 'License is not currently valid';
  }
  x.State=StateLicense;
  notifyListeners();
}

  // List of License 
  List <License> MyLicense=[
    License(State: '',name: "adobe", StartDate: DateTime(2025,6,4), FinDate: DateTime(2025,11,4)),
    License(State: '',name: "microsoft-365", StartDate: DateTime(2025,6,4), FinDate: DateTime(2025,11,4)),
    License(State: '',name: "Mceaa", StartDate: DateTime(2025,6,4), FinDate: DateTime(2025,11,4)),
    License(State: '',name: "Net", StartDate: DateTime(2025,6,4), FinDate: DateTime(2025,11,4)),
    License(State: '',name: "VPN", StartDate: DateTime(2025,6,4), FinDate: DateTime(2025,11,4)),
  ];
  // get the List
  List<License> get getLicense => MyLicense;

  // add element to list 
  void addItem(License x){
    MyLicense.add(x);
  notifyListeners();
  }

  // remove element from List
  void removeItme(License x){
    MyLicense.remove(x);
    notifyListeners();
  }
}