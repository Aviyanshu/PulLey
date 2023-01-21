// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'eventspage.dart';
import 'homepage.dart';
import 'jobspage.dart';
import 'settingspage.dart';


void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex=0;

  final List<Widget> _pages=[
    HomePage(),
    EventsPage(),
    JobsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_pages[_selectedIndex],
      bottomNavigationBar: Container(
        color:Colors.white,
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
            backgroundColor: Colors.white,
            activeColor: Colors.cyan[200],
            tabBackgroundColor: Colors.cyan.shade50,
            padding:EdgeInsets.all(16),
            tabs: const [
            GButton(icon: Icons.home,
            text:'Home',),
            GButton(icon: Icons.event,
            text:'Events'),
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
