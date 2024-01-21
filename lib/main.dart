import 'package:first_app/pages/first_page.dart';
import 'package:first_app/pages/home_page.dart';
import 'package:first_app/pages/add_flight.dart';
import 'package:first_app/pages/login_page.dart';
import 'package:first_app/pages/settings_page.dart';
import 'package:first_app/pages/my_trips_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: LoginPage(),
     routes: {
      '/firstpage': (context) => FirstPage(),
      '/addflight': (context) => AddFlight(),
      '/homepage': (context) => HomePage(),
      '/settingspage': (context) => SettingsPage(),
      '/mytripspage': (context) => MyTripsPage()
     }
    );
  }
}