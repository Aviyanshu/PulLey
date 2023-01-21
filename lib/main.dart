import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

import 'dart:developer' as devtools show log;

import 'package:pulley/views/loginView.dart';
import 'package:pulley/views/registerView.dart';
import 'package:pulley/perspective/studentPerpestive/student.dart';
import 'package:pulley/perspective/orgPerspective/organisation.dart';
import 'package:pulley/perspective/clubPerspective/club.dart';
import 'package:pulley/route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: "PulLey App",
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        homeRoute: (context) => const PulLey(
              title: 'This',
            ),
        registerRoute: (context) => const RegisterView(),
        studentRoute: (context) => const Student(),
        clubRoute: (context) => const Club(),
        organisationRoute: (context) => const Organisation(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

//widget test ma MyApp lai const bata not const banao chha

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                devtools.log("Email is verified");
              } else {
                devtools.log(user.toString());
              }
            } else {
              return const LoginView();
            }
            return const MyHomePage();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

class PulLey extends StatefulWidget {
  const PulLey({super.key, required this.title});

  final String title;

  @override
  State<PulLey> createState() => _PulLeyState();
}

class _PulLeyState extends State<PulLey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("Avi"),
              accountEmail: Text("avi@gmail.com"),
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
            ),
            ListTile(
                title: const Text("This"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(registerRoute);
                })
          ],
        ),
      ),
    );
  }
}
