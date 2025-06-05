import 'package:check_license/Component/Container.dart';
import 'package:check_license/models/DataBsaeLicense.dart';
import 'package:check_license/models/license.dart';
import 'package:check_license/util/printPdf.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class LicenseInformation extends StatelessWidget {
  String name;
  DateTime StartDate;
  DateTime FinDate;
  String state;
  int index;
  LicenseInformation({
    required this.index,
    required this.state,
    required this.FinDate,
    required this.name,
    required this.StartDate,
  });

  @override
  Widget build(BuildContext context) {
    Color? color;
    String formattedStart = DateFormat('MM/dd/yyyy').format(StartDate);
    String formattedEnd = DateFormat('MM/dd/yyyy').format(FinDate);
    switch (state) {
      case 'Valid':
        color = Colors.green.shade300;
        break;
      case 'Missing':
        color = Colors.orange.shade300;
        break;
      case 'expired':
        color = Colors.red.shade300;
        break;
    }
    return Scaffold(
      appBar: AppBar(title: Text("License Information")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(Icons.face),
                  const SizedBox(height: 200),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "name:",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Start Day:",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formattedStart,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Fin day:",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formattedEnd,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Describtion:",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 50,),
                      Text(
                        state,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  List<License> license=Provider.of<Databsaelicense>(context, listen: false).MyLicense;
                  generatePdfReportSingleLicense(license[index]);
                },
                child: MyContainer(
                  icon: Icons.warning_amber_rounded,
                  data: "REPPORT",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
