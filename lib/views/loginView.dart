import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulley/Colors.dart';

import 'dart:developer' as devtools show log;

import 'package:pulley/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/assets/login.png'), fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.25,
              right: 35,
              left: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Enter your password here',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;

                  try {
                    final signedUser =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('isLoggedIn', true);
                    User userLoggedin = FirebaseAuth.instance.currentUser!;
                    final DocumentSnapshot doc_ = await FirebaseFirestore
                        .instance
                        .collection('users')
                        .doc(userLoggedin.uid)
                        .get();
                    devtools.log(userLoggedin.uid);
                    devtools.log(doc_.toString());
                    if (doc_.exists) {
                      devtools.log(doc_.data.toString());
                      final data = doc_.data() as Map<String, dynamic>;
                      final role = data['role'];
                      devtools.log(role);
                      if (role == 'Student') {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          studentRoute,
                          (route) => false,
                        );
                      } else if (role == 'Club') {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          clubRoute,
                          (route) => false,
                        );
                      } else if (role == 'Organisation') {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          organisationRoute,
                          (route) => false,
                        );
                      }
                    } else {
                      devtools.log('Error');
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      devtools.log("User not found");
                    } else if (e.code == 'wrong-password') {
                      devtools.log("Wrong Password");
                    }
                  }
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(color: lightblueColor),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute,
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Not Registered? Click Here",
                    style: TextStyle(color: lightblueColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

roleBased(BuildContext context, User user) {
  return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc('myDocumentID')
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text('Document not found');
        } else if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(data.toString());
        }
        return const Text('LOADING...');
      });
}

Future<bool> showDialogBox(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: const Color.fromARGB(255, 104, 200, 222),
    builder: (context) {
      return AlertDialog(
          title: const Text("Error"),
          content: const Text("Username or Password incorrect"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ]);
    },
  ).then((value) => value ?? false);
}
