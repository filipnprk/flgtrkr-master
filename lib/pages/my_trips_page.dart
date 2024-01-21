import 'package:flutter/material.dart';

class MyTripsPage extends StatelessWidget {
  const MyTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Trips"), centerTitle: true, backgroundColor: Colors.deepPurple,),
    );
  }
}