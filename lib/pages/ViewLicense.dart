import 'package:check_license/Component/Drawer.dart';
import 'package:flutter/material.dart';

class Viewlicense extends StatelessWidget {
  const Viewlicense({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View license"),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
    );
  }
}