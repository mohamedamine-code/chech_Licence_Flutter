import 'package:check_license/Component/Drawer.dart';
import 'package:check_license/Component/MyDevice.dart';
import 'package:check_license/models/DataBase.dart';
import 'package:check_license/util/infromationDevice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Selectdevices extends StatefulWidget {
  const Selectdevices({super.key});

  @override
  State<Selectdevices> createState() => _SelectdevicesState();
}

class _SelectdevicesState extends State<Selectdevices> {
  TextEditingController _searchController = TextEditingController();

  final List<String> _allItems = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Fig',
    'Grape',
    'Kiwi',
  ];
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
    // tiggres the function filterSearch(); when the content of _searchController
    // change .
    _searchController.addListener(() {
      filterSearch();
    });
  }

  void filterSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems =
          _allItems
              .where((item) => item.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final device = context.watch<DatabaseDevices>().getMydevices;
    return Scaffold(
      appBar: AppBar(title: Text("Select devices"), centerTitle: true),
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
                crossAxisCount: 2,
              ),
              itemCount: device.length,
              itemBuilder: (context, index) {
                return MyDevice(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => Infromationdevice(
                              name: device[index].name,
                              id: device[index].id,
                              state: device[index].State?? "null",
                            ),
                      ),
                    );
                  },
                  name: device[index].name,
                  id: device[index].id,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
