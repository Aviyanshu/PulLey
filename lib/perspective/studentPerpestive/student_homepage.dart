import 'package:flutter/material.dart';
import 'package:pulley/Colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          backgroundColor: darkBlueColor,
          foregroundColor: lightblueColor,
        ),
        );
  }
}
