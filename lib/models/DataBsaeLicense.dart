import 'package:check_license/api/LocalNotificationServerce.dart';
import 'package:check_license/models/license.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Databsaelicense extends ChangeNotifier {
  bool notified = false;
  // DateTime(year,month,day)
  String StateLicense = '';

  // list valid license
  List<License> validList = [];

  // list expiring soon license
  List<License> expirngSoonList = [];

  // list Expired license
  List<License> expiredList = [];

  // archivte list
  List<License> archiveList = [];

  // Check the availability of the license by date
  void checkDate(License x) async {
  final prefs = await SharedPreferences.getInstance();
  final notifiedKey = 'notified_${x.name}'; // assuming x.id is unique

  DateTime today = DateTime.now();
  Duration diff = x.FinDate.difference(today);

  // Clear previous state
  validList.remove(x);
  expirngSoonList.remove(x);
  expiredList.remove(x);

  if (x.FinDate.isBefore(today)) {
    StateLicense = 'License has expired';
    expiredList.add(x);
  } else {
    if (diff.inDays < 30) {
      expirngSoonList.add(x);
      bool alreadyNotified = prefs.getBool(notifiedKey) ?? false;
      if (!alreadyNotified) {
        LocalNotificationService.showSimpleNotification(
          '🔔 License Expired',
          'Your license [${x.name}] expired on [${DateFormat.yMMMd().format(x.FinDate)}]. Please renew it.',
          x.name,
          x.FinDate,
        );

        await prefs.setBool(notifiedKey, true);
      }

      if (diff.inDays < 7) {
        StateLicense = 'Less than 1 week remaining';
      } else if (diff.inDays < 14) {
        StateLicense = 'Less than 2 weeks remaining';
      } else {
        StateLicense = 'Less than 1 month remaining';
      }
    } else {
      validList.add(x);
      StateLicense = 'License is valid for more than 1 month';
    }
  }

  x.State = StateLicense;
}

  // List of License
  List<License> MyLicense = [
    License(
      id: '0',
      State: '',
      name: "adobe",
      StartDate: DateTime(2025, 6, 1),
      FinDate: DateTime(2025, 6, 4),
      path: 'assets/img/Adobe-Photoshop-Logo.png',
    ),

    License(
      id: '1',
      State: '',
      name: "microsoft-365",
      StartDate: DateTime(2025, 5, 4),
      FinDate: DateTime(2025, 7, 4),
      path: 'assets/img/express-logo.png',
    ),

    License(
      id: '2',
      State: '',
      name: "Mcea",
      StartDate: DateTime(2025, 5, 20),
      FinDate: DateTime(2025, 6, 4),
      path: 'assets/img/Kaspersky-Logo-1997-500x315.png',
    ),

    License(
      id: '3',
      State: '',
      name: "Net",
      StartDate: DateTime(2025, 6, 4),
      FinDate: DateTime(2025, 11, 4),
      path: 'assets/img/Office-365-Logo-2020.png',
    ),

    License(
      id: '4',
      State: '',
      name: "VPN",
      StartDate: DateTime(2025, 6, 4),
      FinDate: DateTime(2025, 11, 4),
      path: 'assets/img/R.png',
    ),
  ];

  // get the List
  List<License> get getLicense => MyLicense;

  // add element to list
  void addItem(
    String state,
    String path,
    String name,
    DateTime startDate,
    DateTime FinDate,) {
    License x = License(
      id: '1051', // you shoulf fixed 
      State: state,
      path: path,
      name: name,
      StartDate: startDate,
      FinDate: FinDate,
    );
    MyLicense.add(x);
    checkDate(x);
    notifyListeners();
  }

  // remove element from List
  void removeItme(License x) {
    MyLicense.remove(x);
    expiredList.remove(x);
    validList.remove(x);
    expirngSoonList.remove(x);
    expiredList.remove(x);
    archiveList.add(x);
    notifyListeners();
  }

  // to update each state of license
  void updateAllStates() {
    for (var license in MyLicense) {
      checkDate(license);
    }
  }
}
