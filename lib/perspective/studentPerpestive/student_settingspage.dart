import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:pulley/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        ));
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
