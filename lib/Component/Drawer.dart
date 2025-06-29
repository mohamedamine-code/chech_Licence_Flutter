import 'package:check_license/Component/MyListTile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pop(context);
    if (ModalRoute.of(context)?.settings.name != routeName) {
      Navigator.pushReplacementNamed(context, routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          // SizedBox(
          //   height: 50,
          // ),
          DrawerHeader(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.security, size: 50, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    "License Manager",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 8.0),
              children: [
                MyListTile(
                  data: "Dashboard",
                  icon: Icons.dashboard_outlined,
                  onTap: () => _navigateTo(context, '/NEW'),
                ),
                MyListTile(
                  data: "View License",
                  icon: Icons.visibility_outlined,
                  onTap: () => _navigateTo(context, '/NewSelectDevice'),
                ),
                MyListTile(
                  data: "View Archive",
                  icon: Icons.archive_outlined,
                  onTap: () => _navigateTo(context, '/NewViewArchiv'),
                ),
                MyListTile(
                  data: "Add License",
                  icon: Icons.add_circle_outline,
                  onTap: () => _navigateTo(context, '/Newaddlicense'),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              '© 2025 Check License',
              style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
