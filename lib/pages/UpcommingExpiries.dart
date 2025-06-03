import 'package:check_license/Component/Drawer.dart';
import 'package:flutter/material.dart';

class Upcommingexpiries extends StatelessWidget {
  const Upcommingexpiries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcomming expiries"),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
    );
  }
}