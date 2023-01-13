import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
          title: const Text("PulLey-Register"),
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
                hintText: "Enter email here",
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
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  final userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  devtools.log(userCredential.toString());
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'email-already-in-use') {
                    devtools.log('Email already registered');
                  } else if (e.code == 'weak-password') {
                    devtools.log('Weak Password');
                  } else if (e.code == "invalid-email") {
                    devtools.log("Invalid Email Format");
                  } else {
                    devtools.log(e.code.toString());
                  }
                }
              },
              child: const Text("Register as student"),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  final userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  devtools.log(userCredential.toString());
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'email-already-in-use') {
                    devtools.log('Email already registered');
                  } else if (e.code == 'weak-password') {
                    devtools.log('Weak Password');
                  } else if (e.code == "invalid-email") {
                    devtools.log("Invalid Email Format");
                  } else {
                    devtools.log(e.code.toString());
                  }
                }
              },
              child: const Text("Register as club"),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  final userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  devtools.log(userCredential.toString());
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'email-already-in-use') {
                    devtools.log('Email already registered');
                  } else if (e.code == 'weak-password') {
                    devtools.log('Weak Password');
                  } else if (e.code == "invalid-email") {
                    devtools.log("Invalid Email Format");
                  } else {
                    devtools.log(e.code.toString());
                  }
                }
              },
              child: const Text("Register as organisation"),
            ),
          ],
        ));
  }
}
