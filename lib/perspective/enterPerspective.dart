import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as devtools show log;

import 'package:pulley/views/registerView.dart';

class EnterPerspective extends StatefulWidget {
  const EnterPerspective({super.key});

  @override
  State<EnterPerspective> createState() => _EnterPerspectiveState();
}

class _EnterPerspectiveState extends State<EnterPerspective> {
  User? user = FirebaseAuth.instance.currentUser;
  /*DocumentSnapshot roleSnapshot = await FirebaseFirestore.instance
                    .collection('roles')
                    .doc(user?.uid)
                    .get();
                final role = roleSnapshot.data() as Map<String, dynamic>;
                String userRole = role['role'];
                if (userRole == 'Student') {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    studentRoute,
                    (route) => false,
                  );
                } else {
                  devtools.log('error');
                }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select"),
        ),
        body: Row());
  }
}
