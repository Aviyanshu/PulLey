import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pulley/Colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:pulley/Extras/searchscreen.dart';

enum MenuAction { delete, edit }

class OrganisationHomePage extends StatelessWidget {
  const OrganisationHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: darkBlueColor,
          foregroundColor: llightblueColor,
          centerTitle: false,
          title: const Text('PulLey'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                })
          ]),
      backgroundColor: llightblueColor,
      body: _buildVacancyList(),
    );
  }
}

Widget _buildVacancyList() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('_Vacancy_').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: const CircularProgressIndicator(),
        );
      }
      List<QueryDocumentSnapshot<Object?>>? vacancies = snapshot.data?.docs;
      return ListView.builder(
        itemCount: vacancies?.length,
        itemBuilder: (BuildContext context, int index) {
          String userID = (vacancies![index].data() as dynamic)['user'];
          String post = (vacancies[index].data() as dynamic)['post'];
          String qualifications =
              (vacancies[index].data() as dynamic)['qualifications'];
          String deadline = (vacancies[index].data() as dynamic)['deadline'];
          String description =
              (vacancies[index].data() as dynamic)['description'];
          String salary = (vacancies[index].data() as dynamic)['salary'];
          String status = (vacancies[index].data() as dynamic)['status'];
          final documentID = vacancies[index].id;
          User user = FirebaseAuth.instance.currentUser!;
          if (status == 'notFull') {
            if (user.uid == userID) {
              return Container(
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: ListTile(
                  title: Text(
                    post,
                    style: (TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: darkBlueColor)),
                  ),
                  subtitle: Text(
                      "Qualifications: $qualifications\nDeadline: $deadline\nDescription: $description\nSalary: $salary\n"),
                  trailing: PopupMenuButton<MenuAction>(
                    onSelected: (value) async {
                      switch (value) {
                        case MenuAction.delete:
                          await FirebaseFirestore.instance
                              .collection('_Events_')
                              .doc(documentID)
                              .update({'status': 'Full'});
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
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: ListTile(
                  title: Text(
                    post,
                    style: (TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: darkBlueColor)),
                  ),
                  subtitle: Text(
                      "Qualifications: $qualifications\nDeadline: $deadline\nDescription: $description\nSalary: $salary\n"),
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

  comparator(
      QueryDocumentSnapshot<Object?> A, QueryDocumentSnapshot<Object?> B) {}
}
