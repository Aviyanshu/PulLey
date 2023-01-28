import 'package:cloud_firestore/cloud_firestore.dart';
<<<<<<< Updated upstream
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
=======
import 'package:flutter/foundation.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pulley/Colors.dart';
import 'dart:developer' as devtools show log;
import 'package:pulley/Extras/pickImage.dart';
import 'dart:io';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class OrganisationCreate extends StatefulWidget {
  const OrganisationCreate({super.key});

  @override
  _OrganisationCreateState createState() => _OrganisationCreateState();
}

class _OrganisationCreateState extends State<OrganisationCreate> {
  // Uint8List? _file;
  // bool isLoading = false;
  //
  /* _selectImage(BuildContext parentContext) async {
    return showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return SimpleDialog(title: Text('Create post'), children: <Widget>[
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Text('Take a photo'),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Text('Choose from gallery '),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ), */
  /* SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]);
        });
  }
 */
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
<<<<<<< Updated upstream
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
=======
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
                      return 'Please enter the base salary';
                    }
                    return null;
                  },
                  onSaved: (value) => _salary = value!,
                ),
                SizedBox(
                  height: 40,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.upload), onPressed: () {}),
                        SizedBox(width: 10),
                        // Text('Add picture', style: TextStyle(fontSize: 20))
                      ],
                    ),
                  ),
                ),
                /* SizedBox(
                    height: 45,
                    width: 45,
                    child: AspectRatio(
                        aspectRatio: 487 / 452,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(_file!)))))),
                SizedBox(
                  height: 40,
                ), */
                FloatingActionButton.extended(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _saveVacancyToFirebase();
                      final showDialogBox =
                          await showDialogBoxForVacancyAdded(context);
                    }
                    _postcontroller.clear();
                    _salarycontroller.clear;
                    _deadlinecontroller.clear();
                    _qualificationscontroller.clear();
                    _descriptioncontroller.clear();
                  },
                  label: const Text('Announce Vacancy'),
                  icon: Icon(Icons.add),
                  backgroundColor: darkBlueColor,
                  foregroundColor: lightblueColor,
                )
              ],
            )),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
      'status': 'notFull',
=======
>>>>>>> Stashed changes
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
