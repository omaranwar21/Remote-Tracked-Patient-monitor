// ignore: file_names
import 'package:flutter/material.dart';
import 'realtime.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool buttonFlag = false;
  String buttonText = "Channel OFF";

  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add your sidebar content here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                    color: Color(0xff31304D), shape: BoxShape.rectangle),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
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
              ListTile(
                title: const Text('Sign Out'),
                onTap: () {
                  // Handle sidebar item 3 tap
                  Navigator.pop(context); // Close the sidebar
                  Navigator.pushNamed(context, 'login');
                },
              ),
              ListTile(
                title: const Text('Reset Password'),
                onTap: () {
                  // Handle sidebar item 4 tap
                  Navigator.pop(context); // Close the sidebar
                  Navigator.pushNamed(context, 'reset_password');
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle elevated button tap
                setState(() {
                  if (buttonFlag == false) {
                    buttonText = "Channel ON";
                    buttonFlag = true;
                  } else {
                    buttonText = "Channel OFF";
                    buttonFlag = false;
                  }
                });
              },
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}
