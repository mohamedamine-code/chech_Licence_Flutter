import 'package:check_license/Component/Drawer.dart';
import 'package:check_license/Component/MyLicense.dart';
import 'package:check_license/models/DataBsaeLicense.dart';
import 'package:check_license/models/license.dart';
import 'package:check_license/pages/LicenseInformation.dart';
import 'package:check_license/util/printPdf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectLicense extends StatefulWidget {
  const SelectLicense({super.key});

  @override
  State<SelectLicense> createState() => _SelectLicenseState();
}

class _SelectLicenseState extends State<SelectLicense> {

  TextEditingController _searchController = TextEditingController();

  Color? backgroundColor;

  List<License> _filteredItems = [];



  @override
  void initState() {
    super.initState();
    _filteredItems =
        Provider.of<Databsaelicense>(context, listen: false).MyLicense;
    // tiggres the function filterSearch(); when the content of _searchController
    // change .
    _searchController.addListener(() {
      filterSearch();
    });
    Provider.of<Databsaelicense>(context, listen: false).updateAllStates();
  }

  void filterSearch() {
    final query = _searchController.text.toLowerCase();
    final allItems =
        Provider.of<Databsaelicense>(context, listen: false).MyLicense;

    setState(() {
      _filteredItems =
          allItems.where((item) {
            return item.name.toLowerCase().contains(query); // ✅ Correct use
          }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Mylicense = context.watch<Databsaelicense>().getLicense;
    return Scaffold(
      floatingActionButton: AnimatedOpacity(
        opacity: 0.5,
        duration: Duration(microseconds: 1),
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () {
          generatePdfReportAllLicense(Mylicense);
          },
          child: Center(child: Icon(Icons.warning_rounded)),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text("Select License"),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // mainAxisSpacing: 20,
                // crossAxisSpacing: 20,
                crossAxisCount: 1,
              ),
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                switch (Mylicense[index].State) {
                  case 'License is valid for more than 1 month':
                    backgroundColor = Colors.green.shade300;
                    break;
                  case 'Less than 1 month remaining':// 30 -14
                    backgroundColor = Colors.orange.shade300;
                    break;
                  case 'Less than 2 weeks remaining'://14-7
                    backgroundColor = Colors.red.shade300;
                    break;
                    case 'Less than 1 week remaining'://7-0
                    backgroundColor = Colors.red.shade500;
                    break;
                  case 'License is not currently valid':// expired
                    backgroundColor = Colors.black38;
                    break;
                }
                var license = _filteredItems[index];
                return MyLicenseClass(
                  path: license.path,
                  color: backgroundColor ?? Colors.black38,
                  startDate: license.StartDate,
                  finStart: license.FinDate,
                  name: license.name,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => LicenseInformation(
                              path: Mylicense[index].path,
                              index: index,
                              state: Mylicense[index].State,
                              FinDate: Mylicense[index].FinDate,
                              name: Mylicense[index].name,
                              StartDate: Mylicense[index].StartDate,
                            ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          
        ],
        
      ),
    );
  }
}
