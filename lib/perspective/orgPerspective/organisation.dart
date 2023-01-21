import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pulley/route.dart';

class Organisation extends StatefulWidget {
  const Organisation({super.key});

  @override
  State<Organisation> createState() => _OrganisationState();
}

class _OrganisationState extends State<Organisation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organisation'),
      ),
      body: ElevatedButton(
        onPressed: (() {
          signout(context);
        }),
        child: const Text('Singout'),
      ),
    );
  }
}

signout(context) {
  FirebaseAuth.instance.signOut();
  Navigator.of(context).pushNamedAndRemoveUntil(
    loginRoute,
    (route) => false,
  );
}
