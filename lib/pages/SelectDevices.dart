import 'package:check_license/Component/Drawer.dart';
import 'package:flutter/material.dart';

class Selectdevices extends StatelessWidget {
  const Selectdevices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select devices"),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
    );
  }
}