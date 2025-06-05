import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyLicenseClass extends StatelessWidget {
  String name;
  DateTime startDate;
  DateTime finStart;
  VoidCallback onTap;
  Color color;
  String path;
  MyLicenseClass({
    required this.path,
    required this.color,
    required this.startDate,
    required this.finStart,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String formattedStart = DateFormat('MM/dd/yyyy').format(startDate);
    String formattedEnd = DateFormat('MM/dd/yyyy').format(finStart);
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          // color: Colors.redAccent,
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.asset(path,fit: BoxFit.contain,)),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Name :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Start date :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      formattedStart,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fin date :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      formattedEnd,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
