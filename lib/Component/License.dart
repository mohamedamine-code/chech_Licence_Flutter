import 'package:flutter/material.dart';

class MyLicenseClass extends StatelessWidget {
  String name;
  DateTime startDate;
  DateTime finStart;
  VoidCallback onTap;
  Color color;
  MyLicenseClass({
    required this.color,
    required this.startDate,
    required this.finStart,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.face),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(startDate.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(finStart.toString(), style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
