import 'package:check_license/Component/Drawer.dart';
import 'package:check_license/Component/MyLicense.dart';
import 'package:check_license/models/DataBsaeLicense.dart';
import 'package:check_license/models/license.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewArchiv extends StatefulWidget {
  const ViewArchiv({super.key});

  @override
  State<ViewArchiv> createState() => _ViewArchivState();
}

class _ViewArchivState extends State<ViewArchiv> {
  @override
  Widget build(BuildContext context) {
    final expiredItem=context.read<Databsaelicense>().archiveList;
    return Scaffold(
      appBar: AppBar(title: Text("View archive"), centerTitle: true),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5.0),
        child: Column(
          children: [
            Text(
              "Delated License",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                itemCount: expiredItem.length,
                itemBuilder: (context, index) {
                  return MyLicenseClass(
                    path: expiredItem[index].path,
                    color: Colors.red.withValues(alpha: 0.1),
                    startDate: expiredItem[index].StartDate,
                    finStart: expiredItem[index].FinDate,
                    name: expiredItem[index].name,
                    onTap: (){},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
