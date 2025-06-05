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
  String path;
  LicenseInformation({
    required this.path,
    required this.index,
    required this.state,
    required this.FinDate,
    required this.name,
    required this.StartDate,
  });

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    String formattedStart = DateFormat('MM/dd/yyyy').format(StartDate);
    String formattedEnd = DateFormat('MM/dd/yyyy').format(FinDate);
    switch (state) {
      case 'License is valid for more than 1 month':
                    backgroundColor = Colors.green;
                    break;
                  case 'Less than 1 month remaining':// 30 -14
                    backgroundColor = Colors.orange;
                    break;
                  case 'Less than 2 weeks remaining'://14-7
                    backgroundColor = Colors.red;
                    break;
                    case 'Less than 1 week remaining'://7-0
                    backgroundColor = Colors.red;
                    break;
                  case 'License is not currently valid':// expired
                    backgroundColor = Colors.black38;
                    break;
                }
    
    return Scaffold(
      appBar: AppBar(title: Text("License Information")),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(path),
                    const SizedBox(height: 30),
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
                            // color: color,
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
                            color: backgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50,),
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
      ),
    );
  }
}
