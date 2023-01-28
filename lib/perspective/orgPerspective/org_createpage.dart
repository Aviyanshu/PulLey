import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pulley/Colors.dart';
import 'dart:developer' as devtools show log;

FirebaseFirestore firestore = FirebaseFirestore.instance;

class OrganisationCreate extends StatefulWidget {
  const OrganisationCreate({super.key});

  @override
  _OrganisationCreateState createState() => _OrganisationCreateState();
}

class _OrganisationCreateState extends State<OrganisationCreate> {
  final _formKey = GlobalKey<FormState>();
  late String _post;
  late String _qualifications;
  late String _deadline;
  late String _description;
  late String _salary;

  TextEditingController _postcontroller = TextEditingController();
  TextEditingController _qualificationscontroller = TextEditingController();
  TextEditingController _deadlinecontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();
  TextEditingController _salarycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announce Vacancy'),
        centerTitle: true,
        backgroundColor: darkBlueColor,
        foregroundColor: lightblueColor,
      ),
      backgroundColor: llightblueColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
            alignment: Alignment.topCenter, child: _buildAdminVacancyInput()),
      ),
    );
  }

  Widget _buildAdminVacancyInput() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _postcontroller,
                cursorColor: darkBlueColor,
                decoration: InputDecoration(
                  hintText: 'Post Name',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: darkBlueColor),
                      borderRadius: BorderRadius.circular(20)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the open position';
                  }
                  return null;
                },
                onSaved: (value) => _post = value!,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _qualificationscontroller,
                cursorColor: darkBlueColor,
                decoration: InputDecoration(
                  hintText: 'Qualifications',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: darkBlueColor),
                      borderRadius: BorderRadius.circular(20)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the required qualifications';
                  }
                  return null;
                },
                onSaved: (value) => _qualifications = value!,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _deadlinecontroller,
                cursorColor: darkBlueColor,
                decoration: InputDecoration(
                  hintText: 'Submission Deadline',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: darkBlueColor),
                      borderRadius: BorderRadius.circular(20)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter date till which position is open';
                  }
                  return null;
                },
                onSaved: (value) => _deadline = value!,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _descriptioncontroller,
                cursorColor: darkBlueColor,
                decoration: InputDecoration(
                  hintText: 'Responsibilities/Description',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: darkBlueColor),
                      borderRadius: BorderRadius.circular(20)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the job description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _salarycontroller,
                cursorColor: darkBlueColor,
                decoration: InputDecoration(
                  hintText: 'Salary',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: darkBlueColor),
                      borderRadius: BorderRadius.circular(20)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the salary for post';
                  }
                  return null;
                },
                onSaved: (value) => _salary = value!,
              ),
              SizedBox(
                height: 40,
              ),
              FloatingActionButton.extended(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _saveVacancyToFirebase();
                    final showDialogBox =
                        await showDialogBoxForVacancyAdded(context);
                  }
                  _postcontroller.clear();
                  _deadlinecontroller.clear();
                  _qualificationscontroller.clear();
                  _descriptioncontroller.clear();
                  _salarycontroller.clear();
                },
                label: const Text('Announce Vacancy'),
                icon: Icon(Icons.add),
                backgroundColor: darkBlueColor,
                foregroundColor: lightblueColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  _saveVacancyToFirebase() async {
    // Create a new document in the events collection
    User user = FirebaseAuth.instance.currentUser!;
    DocumentReference ref =
        await FirebaseFirestore.instance.collection('_Vacancy_').add({
      'user': user.uid,
      'post': _post,
      'qualifications': _qualifications,
      'deadline': _deadline,
      'description': _description,
      'salary': _salary,
      'status': 'notFull',
    });
    devtools.log("Vacancy announced");
  }
}

Future<bool> showDialogBoxForVacancyAdded(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: const Color.fromARGB(255, 104, 200, 222),
    builder: (context) {
      return AlertDialog(
        title: const Text("Vacancy announced"),
        content: const Text("Vacancy announced successfully"),
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
