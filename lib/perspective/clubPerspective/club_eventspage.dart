import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pulley/Colors.dart';
import 'package:pulley/perspective/clubPerspective/club_mainpage.dart';
import 'package:pulley/route.dart';
import 'dart:developer' as devtools show log;

FirebaseFirestore firestore = FirebaseFirestore.instance;

class ClubEventsPage extends StatefulWidget {
  const ClubEventsPage({super.key});

  @override
  _ClubEventsPageState createState() => _ClubEventsPageState();
}

class _ClubEventsPageState extends State<ClubEventsPage> {
  final _formKey = GlobalKey<FormState>();
  late String _eventName;
  late String _eventLocation;
  late String _eventDate;
  late String _eventTime;
  late String _eventDescription;

  TextEditingController _eventnamecontroller=TextEditingController();
  TextEditingController _eventlocationcontroller=TextEditingController();
  TextEditingController _eventdatecontroller=TextEditingController();
  TextEditingController _eventtimecontroller=TextEditingController();
  TextEditingController _eventdescriptioncontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
        centerTitle: true,
        backgroundColor: darkBlueColor,
        foregroundColor: lightblueColor,
      ),
      backgroundColor: llightblueColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: _buildAdminEventInput()
        ),
      ),
    );
  }

  Widget _buildAdminEventInput() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                controller: _eventnamecontroller,
                cursorColor: darkBlueColor,
                decoration: InputDecoration(hintText: 'Event Name',
                enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: darkBlueColor),
                      borderRadius: BorderRadius.circular(20)
                    ),
                     ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name for the event';
                  }
                  return null;
                },
                onSaved: (value) => _eventName = value!,
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _eventlocationcontroller,
                 cursorColor: darkBlueColor,
                decoration: InputDecoration(hintText: 'Event Location',
                enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: darkBlueColor),
                      borderRadius: BorderRadius.circular(20)
                    ),
                     ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a location for the event';
                  }
                  return null;
                },
                onSaved: (value) => _eventLocation = value!,
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _eventdatecontroller,
                 cursorColor: darkBlueColor,
                decoration: InputDecoration(hintText: 'Event Date (YYYY-MM-DD)',
                enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: darkBlueColor),
                      borderRadius: BorderRadius.circular(20)
                    ),
                     ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a date for the event';
                  }
                  return null;
                },
                onSaved: (value) => _eventDate = value!,
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _eventtimecontroller,
                 cursorColor: darkBlueColor,
                decoration: InputDecoration(hintText: 'Event Time (HH:MM)',
                enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: darkBlueColor),
                      borderRadius: BorderRadius.circular(20)
                    ),
                     ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a time for the event';
                  }
                  return null;
                },
                onSaved: (value) => _eventTime = value!,
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _eventdescriptioncontroller,
                 cursorColor: darkBlueColor,
                decoration: InputDecoration(hintText: 'Event Description',
                enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: darkBlueColor),
                      borderRadius: BorderRadius.circular(20)
                    ),
                     ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your event's description";
                  }
                  return null;
                },
                onSaved: (value) => _eventDescription = value!,
              ),
              SizedBox(height: 40,),
              FloatingActionButton.extended(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _saveEventToFirebase();
                    final showDialogBox =
                        await showDialogBoxForEventAdded(context);
                  }
                  _eventdatecontroller.clear();
                  _eventdescriptioncontroller.clear();
                  _eventnamecontroller.clear();
                  _eventlocationcontroller.clear();
                  _eventtimecontroller.clear();
                },
                label: const Text('Add Event'),
                icon:Icon(Icons.add),
                backgroundColor: darkBlueColor,
                foregroundColor: lightblueColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  _saveEventToFirebase() async {
    // Create a new document in the events collection
    DocumentReference ref =
        await FirebaseFirestore.instance.collection('_Events_').add({
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
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}