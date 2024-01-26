import 'package:first_app/pages/dashboard.dart';
import 'package:first_app/pages/first_page.dart';
import 'package:first_app/pages/home_page.dart';
import 'package:first_app/pages/add_flight.dart';
import 'package:first_app/pages/login_page.dart';
import 'package:first_app/pages/main_page.dart';
import 'package:first_app/pages/settings_page.dart';
import 'package:first_app/pages/my_trips_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool firebaseInitialized = false;
  try {
    await Firebase.initializeApp();
    firebaseInitialized = true;
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }
  runApp(MyApp(firebaseInitialized: firebaseInitialized));
}

class MyApp extends StatelessWidget {
  final bool firebaseInitialized;

  const MyApp({super.key, required this.firebaseInitialized});

  @override
  Widget build(BuildContext context) {
    if (!firebaseInitialized) {
      // This will be shown when Firebase initialization fails
      return MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Failed to initialize Firebase.')),
        ),
      );
    }

    // This will be shown when Firebase is successfully initialized
    return MaterialApp(
      title: 'FLGTRKR',
      theme: ThemeData.dark(),
      home: MainPage(), // or any initial page you want to show
      routes: {
        '/dashboard': (context) => Dashboard(),
        '/firstpage': (context) => FirstPage(),
        '/homepage': (context) => HomePage(),
        '/settingspage': (context) => SettingsPage(),
        '/mytripspage': (context) => MyTripsPage(
            firebaseInitialized: firebaseInitialized), // Pass the flag here
        '/addflightspage': (context) => AddFlight(),
      },
    );
  }
}
