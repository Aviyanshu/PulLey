import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pulley/Colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/image.dart';

class OrganisationHomePage extends StatelessWidget {
  const OrganisationHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: darkBlueColor,
          foregroundColor: llightblueColor,
          centerTitle: true,
          title: const Text('PulLey'),
          ),
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
          String post = (vacancies![index].data() as dynamic)['post'];
          String qualifications = (vacancies[index].data() as dynamic)['qualifications'];
          String deadline = (vacancies[index].data() as dynamic)['deadline'];
          String description=(vacancies[index].data() as dynamic)['description'];
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: ListTile(
              title: Text(post,style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: darkBlueColor)),),
              subtitle: Text("Qualifications: $qualifications\nDeadline: $deadline\nDescription: $description\n"),
              shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: darkBlueColor),
              borderRadius: BorderRadius.circular(10),
  ),
            ),
          );
        },
      );
    },
  );
}

