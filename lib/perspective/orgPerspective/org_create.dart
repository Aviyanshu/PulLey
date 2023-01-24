import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pulley/route.dart';
import 'package:pulley/perspective/orgPerspective/org_mainpage.dart';
import 'dart:developer' as devtools show log;
import 'package:pulley/Colors.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class OrganisationCreate extends StatefulWidget {
  const OrganisationCreate({super.key});

  @override
  State<OrganisationCreate> createState() => _OrganisationCreateState();
}

class _OrganisationCreateState extends State<OrganisationCreate> {
  late String _postname;
  late String _qualifications;
  late String _deadline;
  late String _postdescription;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
          backgroundColor: darkBlueColor,
          foregroundColor: lightblueColor,
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
                alignment: Alignment.topCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _buildAdminVacancyInput(),
                      ),
                    );
                  },
                  child: Text('Announce Vacancy'),
                ))));
  }

  Widget _buildAdminVacancyInput() {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Announce Vacancy'),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  const Text('Post'),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Post'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the post ';
                      }
                      return null;
                    },
                    onSaved: (value) => _postname = value!,
                  ),
                  const Text('Qualifications'),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Qualification'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the required qualifications ';
                      }
                      return null;
                    },
                    onSaved: (value) => _qualifications = value!,
                  ),
                  const Text('Deadline for applying'),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Deadline'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the deadline ';
                      }
                      return null;
                    },
                    onSaved: (value) => _deadline = value!,
                  ),
                  const Text('Post Description'),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Post Description'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the required qualifications ';
                      }
                      return null;
                    },
                    onSaved: (value) => _postdescription = value!,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final showDialogBox =
                            await showDialogBoxforVacancyAnnounced(context);
                      }
                    },
                    child: const Text('Announce Vacancy'),
                  )
                ]))));
  }

  _saveVacancyToFirebase() async {
    DocumentReference ref =
        await FirebaseFirestore.instance.collection('Vacancy').add({
      'post': _postname,
      'qualifications': _qualifications,
      'deadline': _deadline,
      'postdesciption': _postdescription,
    });
    devtools.log("Vacancy announced");
  }

  Future showDialogBoxforVacancyAnnounced(BuildContextcontext) {
    return showDialog(
        context: context,
        barrierColor: darkBlueColor,
        builder: (context) {
          return AlertDialog(
              title: const Text("Vacancy Announced"),
              content: const Text("Vacancy announced successfully"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                )
              ]);
        });
  }
}
