import 'package:check_license/Component/Drawer.dart';
import 'package:check_license/models/DataBsaeLicense.dart';
import 'package:flutter/material.dart';
import 'package:check_license/Component/Container.dart';
import 'package:provider/provider.dart';


class Dashboard extends StatefulWidget {

  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}



class _DashboardState extends State<Dashboard> {
  int total = 0;
  int valid = 0;
  int expiringSoon = 0;
  int expired = 0;

  @override
  void initState() {
    super.initState();
    // Delay to ensure context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateState();
    });
  }

  Future<void> updateState() async {
    final myLicenseProvider = Provider.of<Databsaelicense>(
      context,
      listen: false,
    );

    for (var license in myLicenseProvider.MyLicense) {
      myLicenseProvider.checkDate(license);
    }

    
    setState(() {
      total = myLicenseProvider.MyLicense.length;
      valid = myLicenseProvider.validList.length;
      expiringSoon = myLicenseProvider.expirngSoonList.length;
      expired = myLicenseProvider.expiredList.length;
    });

    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: updateState,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            MyContainer(
              height: 100,
              data: "Total Licenses:",
              value: total.toString(),
              icon: Icons.description,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            MyContainer(
              height: 100,
              value: valid.toString(),
              data: "Valid:",
              icon: Icons.connected_tv,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            MyContainer(
              height: 100,
              value: expiringSoon.toString(),
              data: "Expiring Soon:",
              icon: Icons.warning_amber_rounded,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            MyContainer(
              height: 100,
              value: expired.toString(),
              data: "Expired:",
              icon: Icons.cancel,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
