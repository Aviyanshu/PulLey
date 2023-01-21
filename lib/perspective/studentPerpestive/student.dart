import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pulley/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student'),
      ),
      body: ElevatedButton(
        onPressed: (() {
          signout(context);
        }),
        child: const Text('Signout'),
      ),
    );
  }
}

signout(BuildContext context) async {
  FirebaseAuth.instance.signOut();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', false);
  Navigator.of(context).pushNamedAndRemoveUntil(
    loginRoute,
    (route) => false,
  );
}
