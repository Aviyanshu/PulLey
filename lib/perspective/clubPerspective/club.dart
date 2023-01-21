import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pulley/route.dart';

class Club extends StatefulWidget {
  const Club({super.key});

  @override
  State<Club> createState() => _ClubState();
}

class _ClubState extends State<Club> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club'),
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
