import 'dart:io';

import 'package:check_license/models/DataBsaeLicense.dart';
import 'package:check_license/models/license.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyLicenseClass extends StatelessWidget {
  String name;
  DateTime startDate;
  DateTime finStart;
  VoidCallback onTap;
  Color color;
  String path;
  License? item;
  MyLicenseClass({
    this.item,
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

      void delateIteam(){
      showDialog(context: context, builder: (_){
        return AlertDialog(
          title: Text("Delate license"),
          content: Text("you are sure to delate this license ?"),
          actions: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Text("cancel")),
            IconButton(onPressed: (){
              context.read<Databsaelicense>().removeItme(item!);
              Navigator.pop(context);
            }, icon: Text("yes")),
          ],
        );
      });
    }
    return GestureDetector(
      onLongPress: () {
        delateIteam();
      },
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
            path.isEmpty
          ? SizedBox(
            height: 150,
            width: double.infinity,
            child: Image.asset('assets/Rimg/none-icon-23.jpg', fit: BoxFit.contain))
          : path.startsWith('/data') || path.startsWith('/storage')
          ? SizedBox(
            height: 150,
            width: double.infinity,
            child: Image.file(File(path), fit: BoxFit.contain))
          : SizedBox(
            height: 150,
            width: double.infinity,
            child: Image.asset(path, fit: BoxFit.contain)),// assuming it's from assets
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
