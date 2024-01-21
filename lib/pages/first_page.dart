import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Page"), centerTitle: true, backgroundColor: Colors.amber,),
      drawer: Drawer(
        backgroundColor: Colors.lightBlue[100],
        child: Column(
          children: [
            // common to place a drawer header 
            DrawerHeader(
              child: Icon(Icons.car_rental, size: 48),
              
            ),
            // home page list title 
            ListTile(
              leading: Icon(Icons.home),
              title: Text("HOME"),
              onTap: () {
                // pop drawer first 
                Navigator.pop(context);
                // go to the homepage 
                Navigator.pushNamed(context, '/homepage');
              },
            ),
            // My Trips Page 
            ListTile(
              leading: Icon(Icons.trip_origin),
              title: Text("MY TRIPS"),
              onTap: () {
                // pop drawer first 
                Navigator.pop(context);
                // go to the homepage 
                Navigator.pushNamed(context, '/mytripspage');
              },
            ),
            // Add Flight Page 
            ListTile(
              leading: Icon(Icons.flight),
              title: Text("ADD FLIGHT"),
              onTap: () {
                // pop drawer first 
                Navigator.pop(context);
                // go to the homepage 
                Navigator.pushNamed(context, '/addflight');
              },
            ),
            // setting page list title 
             ListTile(
              leading: Icon(Icons.settings),
              title: Text("SETTINGS"),
              onTap: () {
                // go to the settings page
                Navigator.pushNamed(context, '/settingspage');
              },
            )
          ]
        )
      ),
    );
  }
}