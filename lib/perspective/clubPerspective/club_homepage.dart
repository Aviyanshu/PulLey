import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pulley/Colors.dart';
import 'package:pulley/perspective/clubPerspective/club_mainpage.dart';
import 'package:pulley/route.dart';
import 'dart:developer' as devtools show log;

FirebaseFirestore firestore = FirebaseFirestore.instance;

class ClubHomePage extends StatefulWidget {
  const ClubHomePage({super.key});

  @override
  _ClubHomePageState createState() => _ClubHomePageState();
}

class _ClubHomePageState extends State<ClubHomePage> {
  final _formKey = GlobalKey<FormState>();
  late String _eventName;
  late String _eventLocation;
  late String _eventDate;
  late String _eventTime;
  late String _eventDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Homepage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => _buildAdminEventInput(),
                ),
              );
            },
            child: const Text("Add an Event"),
          ),
        ),
      ),
    );
  }

  Widget _buildAdminEventInput() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create an Event'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const Text('Event Name'),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Event Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name for the event';
                }
                return null;
              },
              onSaved: (value) => _eventName = value!,
            ),
            const Text('Event Location'),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Event Location'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a location for the event';
                }
                return null;
              },
              onSaved: (value) => _eventLocation = value!,
            ),
            const Text('Event Date'),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Event Date (YYYY-MM-DD)'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a date for the event';
                }
                return null;
              },
              onSaved: (value) => _eventDate = value!,
            ),
            const Text('Event Time'),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Event Time (HH:MM)'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a time for the event';
                }
                return null;
              },
              onSaved: (value) => _eventTime = value!,
            ),
            const Text('Event Description'),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Event Description'),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your event's description";
                }
                return null;
              },
              onSaved: (value) => _eventDescription = value!,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _saveEventToFirebase();
                }
              },
              child: const Text('Add Event'),
            )
          ],
        ),
      ),
    );
  }

  _saveEventToFirebase() async {
    // Create a new document in the events collection
    DocumentReference ref =
        await FirebaseFirestore.instance.collection('events').add({
      'name': _eventName,
      'location': _eventLocation,
      'date': _eventDate,
      'time': _eventTime,
      'description': _eventDescription,
    });
    devtools.log("Event added");
  }
}

Future<bool> showDialogBoxForEventAdded(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: const Color.fromARGB(255, 104, 200, 222),
    builder: (context) {
      return AlertDialog(
        title: const Text("Event Added"),
        content: const Text("Event added successfully"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
