import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pulley/Colors.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Home Page"),
//           backgroundColor: darkBlueColor,
//           foregroundColor: lightblueColor,
//         ),
//         backgroundColor: llightblueColor,
//         );
//   }
// }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
   late String _eventName;
  late String _eventLocation;
  late String _eventDate;
  late String _eventTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _buildAdminEventInput(),
      ),
    );
  }

  Widget _buildAdminEventInput() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Event Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a name for the event';
              }
              return null;
            },
            onSaved: (value) => _eventName = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Event Location'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a location for the event';
              }
              return null;
            },
            onSaved: (value) => _eventLocation = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Event Date (YYYY-MM-DD)'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a date for the event';
              }
              return null;
            },
            onSaved: (value) => _eventDate = value!,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Event Time (HH:MM)'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a time for the event';
              }
              return null;
            },
            onSaved: (value) => _eventTime = value!,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _saveEventToFirebase();
              }
            },
            child: Text('Add Event'),
          )
        ],
      ),
    );
  }

  _saveEventToFirebase() async {
    // Create a new document in the events collection
    DocumentReference ref = await FirebaseFirestore.instance.collection('events').add({
      'name': _eventName,
      'location': _eventLocation,
      'date': _eventDate,
      'time': _eventTime,
    });
    print('Event added');
  }
}