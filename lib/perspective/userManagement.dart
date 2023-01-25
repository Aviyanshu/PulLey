import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pulley/perspective/orgPerspective/org_mainpage.dart';
import 'package:pulley/perspective/studentPerpestive/student_homepage.dart';
import 'package:pulley/perspective/studentPerpestive/student_mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:pulley/perspective/clubPerspective/club_homepage.dart';
import 'package:pulley/perspective/studentPerpestive/student_mainpage.dart';
import 'package:pulley/route.dart';
import 'dart:developer' as devtools show log;

import 'package:pulley/views/loginView.dart';

import 'clubPerspective/club_mainpage.dart';

class UserManagement {
  Future<Widget> handleUser(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const LoginView();
    } else {
      final DocumentSnapshot doc_ = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc_.exists) {
        final data = doc_.data() as Map<String, dynamic>;
        final role = data['role'];
        if (role == 'Student') {
          return const StudentMainPage();
        } else if (role == 'Club') {
          return const ClubMainPage();
        } else if (role == 'Organisation') {
          return const OrganisationMainPage();
        } else {
          devtools.log('Error');
        }
      }
    }
    return const LoginView();
  }
}
