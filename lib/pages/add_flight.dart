import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFlight extends StatefulWidget {
  const AddFlight({super.key});

  @override
  State<AddFlight> createState() => _AddFlightState();
}

class _AddFlightState extends State<AddFlight> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController departureAirportController =
      TextEditingController();
  final TextEditingController arrivalAirportController =
      TextEditingController();
  DateTime selectedDate = DateTime.now();
  String selectedFormattedDate = "";

  void submitUserData(
      String departureAirport, String arrivalAirport, String flightDate) {
    FirebaseFirestore.instance.collection('user_flights').add({
      'departure_airport': departureAirport,
      'arrival_airport': arrivalAirport,
      'flight_date': flightDate
    });
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate != null && pickedDate != selectedDate) {
        // Format the date
        String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
        setState(() {
          selectedFormattedDate = formattedDate;
        });
      }
    });
  }

  @override
  void dispose() {
    //dispose the controller when the widget is removed
    departureAirportController.dispose();
    arrivalAirportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Flight'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'FLGTRKR MENU',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pushNamed(context, '/dashboardpage');
              },
            ),
            ListTile(
              leading: Icon(Icons.flight),
              title: Text('My Flights'),
              onTap: () {
                Navigator.pushNamed(context, '/mytripspage');
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Flights'),
              onTap: () {
                Navigator.pushNamed(context, '/addflightspage');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settingspage');
              },
            ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Login'),
              onTap: () {
                Navigator.pushNamed(context, '/loginpage');
              },
            ),
            // Add other ListTile widgets for different pages as needed
            // loginpage
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: departureAirportController,
                decoration: InputDecoration(
                  labelText: 'Departure Airport:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid Departure Airport:';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: arrivalAirportController,
                decoration: InputDecoration(
                  labelText: 'Arrival Airport:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid Arrival Airport:';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            // Add Cupertino Style Date Picker
            MaterialButton(
              onPressed: _showDatePicker,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('Choose Date',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    )),
              ),
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // validate returns true if the form is valid
                    if (_formKey.currentState!.validate()) {
                      // if the form is valid, display the snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                      submitUserData(departureAirportController.text,
                          arrivalAirportController.text, selectedFormattedDate);
                    }
                  },
                  child: Text("Add Flight"),
                ))
          ],
        ),
      ),
    );
  }
}
