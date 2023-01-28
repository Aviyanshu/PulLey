import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pulley/Colors.dart';

import '../../Extras/searchscreen.dart';

import 'dart:developer' as devtools show log;

class ClubHomePage extends StatefulWidget {
  const ClubHomePage({super.key});

  @override
  State<ClubHomePage> createState() => _ClubHomePageState();
}

enum MenuAction { edit, delete }

class _ClubHomePageState extends State<ClubHomePage> {
  final List<DropdownMenuItem<String>> _dropdownItems = [
    const DropdownMenuItem(
      value: 'Edit',
      child: Text('Edit'),
    ),
    const DropdownMenuItem(
      value: 'Delete',
      child: Text('Delete'),
    ),
  ];
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PulLey"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              })
        ],
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
    stream: FirebaseFirestore.instance.collection('_Events_').snapshots(),
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
          String userID = (events![index].data() as dynamic)['user'];
          String eventName = (events[index].data() as dynamic)['name'];
          String eventLocation = (events[index].data() as dynamic)['location'];
          String eventDate = (events[index].data() as dynamic)['date'];
          String eventTime = (events[index].data() as dynamic)['time'];
          String eventDescription =
              (events[index].data() as dynamic)['description'];
          String eventActive = (events[index].data() as dynamic)['active'];
          final documentID = events[index].id;
          User user = FirebaseAuth.instance.currentUser!;
          if (eventActive == 'isActive') {
            if (user.uid == userID) {
              return Container(
                margin: EdgeInsets.only(left: 7, right: 7, top: 7, bottom: 7),
                child: ListTile(
                  title: Text(
                    eventName,
                    style: (TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: darkBlueColor)),
                  ),
                  subtitle: Text(
                      "Location:$eventLocation\nDate:$eventDate\nTime:$eventTime\nDescription:$eventDescription\n"),
                  trailing: PopupMenuButton<MenuAction>(
                    onSelected: (value) async {
                      switch (value) {
                        case MenuAction.delete:
                          await FirebaseFirestore.instance
                              .collection('_Events_')
                              .doc(documentID)
                              .update({'active': 'inActive'});
                          break;
                        default:
                          break;
                      }
                    },
                    itemBuilder: (context) {
                      return const [
                        PopupMenuItem<MenuAction>(
                          value: MenuAction.delete,
                          child: Text('Delete'),
                        )
                      ];
                    },
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: darkBlueColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.only(left: 7, right: 7, top: 7, bottom: 7),
                child: ListTile(
                  title: Text(
                    eventName,
                    style: (TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: darkBlueColor)),
                  ),
                  subtitle: Text(
                      "Location:$eventLocation\nDate:$eventDate\nTime:$eventTime\nDescription:$eventDescription\n"),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: darkBlueColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }
          } else {
            return Container();
          }
        },
      );
    },
  );
}

/* _showDeleteDialog(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete post"),
        content: Text("Are you sure you want to delete this post?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          RaisedButton(
            child: Text("Delete"),
            onPressed: () {
              setState(() {
                _posts.removeAt(index);
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


trailing: PopupMenuButton<MenuAction>(
                  onSelected: (value) async {
                    switch (value) {
                      case MenuAction.delete:
                        await FirebaseFirestore.instance
                            .collection('_Events_')
                            .doc(documentID)
                            .update({'active': 'inActive'});
                        break;
                      default:
                        break;
                    }
                  },
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem<MenuAction>(
                        value: MenuAction.delete,
                        child: Text('Delete'),
                      )
                    ];
                  },
                ),

 */