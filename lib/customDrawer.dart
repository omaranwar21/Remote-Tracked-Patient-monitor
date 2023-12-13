import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add your sidebar content here
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff31304D),
            ),
            child: Text(
              'Sidebar Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Real-time Plot'),
            onTap: () {
              // Handle sidebar item 1 tap
              Navigator.pop(context); // Close the sidebar
              Navigator.pushNamed(context, 'plot');
            },
          ),
          ListTile(
            title: const Text('Spo2'),
            onTap: () {
              // Handle sidebar item 2 tap
              Navigator.pop(context); // Close the sidebar
              Navigator.pushNamed(context, 'home');
            },
          ),
          // Add more sidebar items as needed
        ],
      ),
    );
  }
}