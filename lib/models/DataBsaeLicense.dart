import 'package:check_license/api/LocalNotificationServerce.dart';
import 'package:check_license/models/license.dart';
import 'package:flutter/material.dart';

class Databsaelicense extends ChangeNotifier {
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
  void checkDate(License x) {
    DateTime today = DateTime.now();
    Duration diff = x.FinDate.difference(today);

    // Clear previous state to avoid duplicates on re-check
    validList.remove(x);
    expirngSoonList.remove(x);
    expiredList.remove(x);

    if (x.FinDate.isBefore(today)) {
      // License expired
      StateLicense = 'License has expired';
      expiredList.add(x);
    } else {
      // License is active
      if (diff.inDays < 7) {
        StateLicense = 'Less than 1 week remaining';
        expirngSoonList.add(x);
        LocalNotificationService.showSimpleNotification('ckeck Lisence','your Lisence it will be expired Soon !!');
      } else if (diff.inDays < 14) {
        StateLicense = 'Less than 2 weeks remaining';
        expirngSoonList.add(x);
        LocalNotificationService.showSimpleNotification('ckeck Lisence','your Lisence it will be expired Soon !!');
      } else if (diff.inDays < 30) {
        StateLicense = 'Less than 1 month remaining';
        expirngSoonList.add(x);
        LocalNotificationService.showSimpleNotification('ckeck Lisence','your Lisence it will be expired Soon !!');
      } else {
        StateLicense = 'License is valid for more than 1 month';
        validList.add(x);
      }
    }

    x.State = StateLicense;
  }

  // List of License
  List<License> MyLicense = [
    License(
      State: '',
      name: "adobe",
      StartDate: DateTime(2025, 6, 1),
      FinDate: DateTime(2025, 6, 4),
      path: 'assets/img/Adobe-Photoshop-Logo.png',
    ),

    License(
      State: '',
      name: "microsoft-365",
      StartDate: DateTime(2025, 5, 4),
      FinDate: DateTime(2025, 7, 4),
      path: 'assets/img/express-logo.png',
    ),

    License(
      State: '',
      name: "Mcea",
      StartDate: DateTime(2025, 5, 20),
      FinDate: DateTime(2025, 6, 4),
      path: 'assets/img/Kaspersky-Logo-1997-500x315.png',
    ),

    License(
      State: '',
      name: "Net",
      StartDate: DateTime(2025, 6, 4),
      FinDate: DateTime(2025, 11, 4),
      path: 'assets/img/Office-365-Logo-2020.png',
    ),

    License(
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
    DateTime FinDate,
  ) {
    License x = License(
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
