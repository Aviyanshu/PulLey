import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:pulley/perspective/clubPerspective/club.dart';
import 'package:pulley/perspective/orgPerspective/organisation.dart';
import 'package:pulley/perspective/studentPerpestive/student.dart';
import 'package:pulley/route.dart';
import 'dart:developer' as devtools show log;

import 'package:pulley/views/loginView.dart';

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
          return const Student();
        } else if (role == 'Club') {
          return const Club();
        } else if (role == 'Organisation') {
          return const Organisation();
        } else {
          devtools.log('Error');
        }
      }
    }
    return const LoginView();
  }
}
