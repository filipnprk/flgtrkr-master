import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/auth/auth_page.dart';
import 'package:first_app/pages/dashboard.dart';
import 'package:first_app/pages/login_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Dashboard();
        } else {
          return AuthPage();
        }
      },
    ));
  }
}
