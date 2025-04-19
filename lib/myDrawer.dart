import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Color(0xFF7D6BA3),
        ),
        child: Center( 
          child: Text(
            "Mood Tracker",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'InsideOut',
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.create),
        title: const Text('Add an Entry'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/add-entry');
        },
      ),
      ListTile(
        leading: Icon(Icons.format_list_bulleted),
        title: const Text('Mood Entries'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/entries');
        },
      ),
    ],
  ),
);

  }
}