import 'package:flutter/material.dart';

class AddFlight extends StatelessWidget {
  const AddFlight({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ADD FLIGHT'), centerTitle: true, backgroundColor: Colors.deepOrangeAccent,),
    );
  }
}