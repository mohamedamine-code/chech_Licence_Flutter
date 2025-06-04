import 'package:check_license/Component/MyListTile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child:
            Icon(Icons.storage,size: 50,),
          ),
          MyListTile(
            data: "DashBored",
            icon: Icons.dashboard,
            onTap: () {
              Navigator.pushNamed(context, '/');
              
            },
          ),
          MyListTile(
            data: "Select License",
            icon: Icons.device_unknown,
            onTap: () {
              
              Navigator.pushNamed(context, '/SelectDevice');
            },
          ),
          MyListTile(
            data: "Upcomming Expiries License",
            icon: Icons.explore,
            onTap: () {
              Navigator.pushNamed(context, '/UpCommingExpiries');
            },
          ),
          MyListTile(
            data: "View License",
            icon: Icons.panorama_photosphere,
            onTap: () {
              Navigator.pushNamed(context, '/ViewLicense');
            },
          ),
        ],
      ),
    );
  }
}