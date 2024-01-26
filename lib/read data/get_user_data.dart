import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserData extends StatefulWidget {
  final String documentId;

  GetUserData({required this.documentId});

  @override
  _GetUserDataState createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {
  late Future<DocumentSnapshot> _userData;

  @override
  void initState() {
    super.initState();
    _userData = FirebaseFirestore.instance
        .collection('user_flights')
        .doc(widget.documentId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Departure Airport: ${data['departure_airport']}'),
                  Text('Arrival Airport: ${data['arrival_airport']}'),
                  Text('Flight Date: ${data['flight_date']}'),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
          }
          return Text('Loading...');
        });
  }
}
