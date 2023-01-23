import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import '../route.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _username;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _role;
  // final Map<String, String> _roles = {
  //   'student': 'student',
  //   'club': 'club',
  //   'organisation': 'organisation',
  // };

  @override
  void initState() {
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _role = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _role.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final List<DropdownMenuItem<String>> _dropdownItems = [
    const DropdownMenuItem(
      value: 'Student',
      child: Text('Student'),
    ),
    const DropdownMenuItem(
      value: 'Club',
      child: Text('Club'),
    ),
    const DropdownMenuItem(
      value: 'Organisation',
      child: Text('Organisation'),
    ),
    // Add more options
  ];
  String? _selectedValue;

  //final CollectionReference rolesCollection =
  //FirebaseFirestore.instance.collection('roles');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PulLey-Register"),
        backgroundColor: const Color.fromARGB(255, 104, 200, 222),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text('Name:'),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              controller: _username,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const Text('Email Address:'),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const Text('Password:'),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Please enter a strong password';
                }
                return null;
              },
            ),
            const Text('Role:'),
            DropdownButton(
              value: _selectedValue,
              items: _dropdownItems,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                  _role.text = value!;
                });
              },
            ),
            TextButton(
              onPressed: () async {
                final username = _username.text;
                final email = _email.text;
                final password = _password.text;
                final role = _role.text;
                try {
                  final userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  devtools.log(userCredential.toString());
                  User user = FirebaseAuth.instance.currentUser!;
                  final CollectionReference userCollection =
                      FirebaseFirestore.instance.collection('users');
                  try {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .set({
                      'username': username,
                      'email': email,
                      'password': password,
                      'role': role,
                    });
                  } catch (e) {
                    devtools.log(e.toString());
                  }
                  final shouldRegister = await showDialogBox(context);
                  if (shouldRegister) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    );
                  }
                } catch (e) {
                  devtools.log(e.toString());
                }
              },
              child: const Text("Register"),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (route) => false,
                  );
                },
                child: const Text('Already registered? Login Here'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

Future<bool> showDialogBox(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: const Color.fromARGB(255, 104, 200, 222),
    builder: (context) {
      return AlertDialog(
        title: const Text("Registered"),
        content: const Text("You have been registered successfully"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
