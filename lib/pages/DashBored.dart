import 'package:check_license/Component/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:check_license/Component/Container.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MyContainer(
              height: 100,
              data: "Total Licenses:",
              value: "22",
              icon: Icons.description,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            MyContainer(
              height: 100,
              value: '11',
              data: "Valid:",
              icon: Icons.connected_tv,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            MyContainer(
              height: 100,
              value: "7",
              data: "Expiring Soon:",
              icon: Icons.warning_amber_rounded,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            MyContainer(
              height: 100,
              value: "5",
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
