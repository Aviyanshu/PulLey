import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'dart:developer' as devtools show log;

import 'package:pulley/route.dart';
import 'package:pulley/views/registerView.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PulLey-Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your email here',
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your password here',
              border: OutlineInputBorder(),
            ),
          ),
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueGrey,
                width: 2,
              ),
            ),
            child: TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                try {
                  final UserCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    homeRoute,
                    (route) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    devtools.log("User not found");
                  } else if (e.code == 'wrong-password') {
                    devtools.log("Wrong Password");
                  }
                }
              },
              child: const Text("Login as Student"),
            ),
          ),
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueGrey,
                width: 2,
              ),
            ),
            child: TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                try {
                  final UserCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    devtools.log("User not found");
                  } else if (e.code == 'wrong-password') {
                    devtools.log("Wrong Password");
                  }
                }
              },
              child: const Text("Login as Club"),
            ),
          ),
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueGrey,
                width: 2,
              ),
            ),
            child: TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                try {
                  final UserCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    devtools.log("User not found");
                  } else if (e.code == 'wrong-password') {
                    devtools.log("Wrong Password");
                  }
                }
              },
              child: const Text("Login as Organisation"),
            ),
          ),
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueGrey,
                width: 2,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                  );
                },
                child: const Text("Not Registered? Click Here"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
