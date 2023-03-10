import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pulley/Colors.dart';
import 'package:pulley/perspective/studentPerpestive/student_homepage.dart';
import 'package:pulley/perspective/studentPerpestive/student_settingspage.dart';
import 'package:pulley/perspective/studentPerpestive/students_jobspage.dart';


class StudentMainPage extends StatefulWidget {
  const StudentMainPage({super.key});

  @override
  State<StudentMainPage> createState() => _MainPageState();
}

class _MainPageState extends State<StudentMainPage> {
  int _selectedIndex=0;

  final List<Widget> _pages=[
    StudentHomePage(),
    JobsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_pages[_selectedIndex],
      backgroundColor: llightblueColor,
      bottomNavigationBar: Container(
        color: llightblueColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:10, vertical:8),
          child: GNav(
            gap:8,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor:llightblueColor,
            activeColor: lightblueColor,
            tabBackgroundColor: darkBlueColor,
            padding:EdgeInsets.all(16),
            tabs: const [
            GButton(icon: Icons.home,
            text:'Home',),
            GButton(icon: Icons.business,
            text:'Jobs'),
            GButton(icon: Icons.settings,
            text:'Settings'),
          ]),
        ),
      ),
    );
  }
}


