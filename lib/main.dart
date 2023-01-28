import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pulley/perspective/clubPerspective/club_mainpage.dart';
import 'package:pulley/perspective/orgPerspective/org_mainpage.dart';
import 'package:pulley/perspective/studentPerpestive/student_homepage.dart';
import 'package:pulley/perspective/userManagement.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

import 'dart:developer' as devtools show log;

import 'package:pulley/views/loginView.dart';
import 'package:pulley/views/registerView.dart';
import 'package:pulley/perspective/studentPerpestive/student_mainpage.dart';
import 'package:pulley/perspective/clubPerspective/club_homepage.dart';
import 'package:pulley/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: "PulLey App",
      themeMode: ThemeMode.dark,
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        studentRoute: (context) => const StudentMainPage(),
        clubRoute: (context) => const ClubMainPage(),
        organisationRoute: (context) => const OrganisationMainPage(),
      },
      debugShowCheckedModeBanner: false,
      home: const PulLey(
        title: 'PulLey',
      ),
    ),
  );
}

class PulLey extends StatefulWidget {
  const PulLey({super.key, required this.title});

  final String title;

  @override
  State<PulLey> createState() => _PulLeyState();
}

class _PulLeyState extends State<PulLey> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = pref.getBool('isLoggedIn') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return FutureBuilder(
        future: UserManagement().handleUser(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Container(child: snapshot.data);
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            /* () async {
                final showIndicator = await showProgressDialog();
                //};
                return showIndicator;
              };
              break; */

            default:
              return const LoginView();
          }
        },
      );
    } else {
      return const LoginView();
    }
  }

  Future<Widget> showProgressDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text('Please wait'),
              ],
            ),
          ),
        );
      },
    ) as Widget;
  }
}
