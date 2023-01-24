import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pulley/Colors.dart';
import 'package:pulley/perspective/orgPerspective/org_create.dart';
import 'package:pulley/perspective/orgPerspective/org_homepage.dart';
import 'package:pulley/perspective/orgPerspective/org_settings.dart';
//import 'package:pulley/perspective/orgPerspective/org_create.dart';
//import 'package:pulley/perspective/orgPerspective/org_homepage.dart';
//import 'package:pulley/perspective/orgPerspective/org_settings.dart';
import 'package:pulley/perspective/studentPerpestive/student_eventspage.dart';
import 'package:pulley/perspective/studentPerpestive/student_homepage.dart';
//import 'package:pulley/perspective/orgPerspective/org_settings.dart';
import 'package:pulley/perspective/studentPerpestive/students_jobspage.dart';
import 'package:pulley/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrganisationMainPage extends StatefulWidget {
  const OrganisationMainPage({super.key});

  @override
  State<OrganisationMainPage> createState() => _MainPageState();
}

class _MainPageState extends State<OrganisationMainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    OrganisationHomePage(),
    OrganisationCreate(),
    OrganisationSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      backgroundColor: llightblueColor,
      bottomNavigationBar: Container(
        color: llightblueColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: GNav(
              gap: 8,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: llightblueColor,
              activeColor: lightblueColor,
              tabBackgroundColor: darkBlueColor,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(icon: Icons.add, text: 'Create'),
                GButton(icon: Icons.account_circle, text: 'Profile'),
              ]),
        ),
      ),
    );
  }
}
