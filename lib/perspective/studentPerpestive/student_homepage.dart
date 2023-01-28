import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pulley/Colors.dart';
import 'package:pulley/Extras/searchscreen.dart';

import '../../Extras/searchscreen.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

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
          String eventName = (events![index].data() as dynamic)['name'];
          String eventLocation = (events[index].data() as dynamic)['location'];
          String eventDate = (events[index].data() as dynamic)['date'];
          String eventTime = (events[index].data() as dynamic)['time'];
          String eventDescription =
              (events[index].data() as dynamic)['description'];
<<<<<<< Updated upstream
          String eventActive = (events[index].data() as dynamic)['active'];
          if (eventActive == 'isActive') {
            return Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
                trailing: IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () {
                      /* Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context) => CommentsScreen(postId: null,))
                  ); */
                    }),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: darkBlueColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
=======
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  /*  LikeAnimation(
                    isAnimating: snap['likes'].contains(user.uid),
                    smallLike: true, */
                  IconButton(
                      icon: Icon(Icons.favorite_border), onPressed: () {}),
                  IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
>>>>>>> Stashed changes
        },
      );
    },
  );
}
