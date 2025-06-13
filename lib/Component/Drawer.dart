import 'package:check_license/Component/MyListTile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void _navigateTo(BuildContext context, String routeName) {
    // Close the drawer first
    Navigator.pop(context);
    // Avoid stacking the same screen
    if (ModalRoute.of(context)?.settings.name != routeName) {
      Navigator.pushReplacementNamed(context, routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(child: Icon(Icons.storage, size: 50)),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Column(
              children: [
                MyListTile(
                  data: "Dashboard",
                  icon: Icons.dashboard,
                  onTap: () => _navigateTo(context, '/'),
                ),
               
                MyListTile(
                  data: "View License",
                  icon: Icons.panorama_photosphere,
                  onTap: () => _navigateTo(context, '/SelectDevice'),
                ),
              
                MyListTile(
                  data: "View archive",
                  icon: Icons.delete,
                  onTap: () => _navigateTo(context, '/ViewArchiv'),
                ),
                MyListTile(
                  data: "Add License",
                  icon: Icons.library_add,
                  onTap: () => _navigateTo(context, '/addlicense'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
