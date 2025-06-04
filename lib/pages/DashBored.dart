import 'package:check_license/Component/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:check_license/Component/Container.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar:  AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        elevation: 0,
      
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MyContainer(
              data: "Total Licenses: 22",
              icon: Icons.description,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyContainer(
                  
                  data: "Valid: 1",
                  icon: Icons.connected_tv,
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                MyContainer(
                  
                  data: "Expiring Soon: 2",
                  icon: Icons.warning_amber_rounded,
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                MyContainer(
                  data: "Expired: 1",
                  icon: Icons.cancel,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
