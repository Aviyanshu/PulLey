import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../route.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings Page"),
      ),
      body: ElevatedButton(
        onPressed: (() {
          signout(context);
        }),
        child: const Text('Singout'),
      )
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