import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/read%20data/get_user_data.dart';
import 'trip_details_page.dart';
import 'package:flutter/material.dart';

class MyTripsPage extends StatefulWidget {
  final bool firebaseInitialized;
  const MyTripsPage({Key? key, required this.firebaseInitialized})
      : super(key: key);

  @override
  State<MyTripsPage> createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage> {
  // document ids
  List<String> docIDs = [];

  // get Doc ids
  Future getDocId() async {
    setState(() {
      docIDs.clear();
    });

    await FirebaseFirestore.instance
        .collection('user_flights')
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            setState(() {
              docIDs.add(document.reference.id);
            });
          }),
        )
        .catchError((error) {
      // handle any errors here
      print("Error fetching data: $error");
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.firebaseInitialized) {
      getDocId();
    } else {
      print("Firebase is not initialized!");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // call get doc id to fetch data every time dependencies change
    getDocId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Flights')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30.0),
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  // You might want to handle different states of the snapshot (e.g., loading, error)
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Assuming snapshot.data is available
                    return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ListTile(
                            title: GetUserData(documentId: docIDs[index]),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {
                              //Implementing Navigator.pushReplacement
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TripDetailsPage()),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
