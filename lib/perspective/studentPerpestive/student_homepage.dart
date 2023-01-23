import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pulley/Colors.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: darkBlueColor,
        foregroundColor: lightblueColor,
      ),
      backgroundColor: llightblueColor,
      body: _buildEventList(),
    );
  }
}

Widget _buildEventList() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('events').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: const CircularProgressIndicator(),
        );
      }
      List<QueryDocumentSnapshot<Object?>>? events = snapshot.data?.docs;
      return ListView.builder(
        itemCount: events?.length,
        itemBuilder: (BuildContext context, int index) {
          String eventName = (events![index].data() as dynamic)['name'];
          String eventLocation = (events[index].data() as dynamic)['location'];
          String eventDate = (events[index].data() as dynamic)['date'];
          String eventTime = (events[index].data() as dynamic)['time'];
          return ListTile(
            title: Text(eventName),
            subtitle: Text("$eventLocation, $eventDate, $eventTime"),
          );
        },
      );
    },
  );
}
