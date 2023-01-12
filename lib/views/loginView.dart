import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                final signedUser =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLoggedIn', true);
                User userLoggedin = FirebaseAuth.instance.currentUser!;
                final DocumentSnapshot doc_ = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(userLoggedin.uid)
                    .get();
                devtools.log(userLoggedin.uid);
                devtools.log(doc_.toString());
                if (doc_.exists) {
                  devtools.log(doc_.data.toString());
                  final data = doc_.data() as Map<String, dynamic>;
                  final role = data['role'];
                  devtools.log(role);
                  if (role == 'Student') {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      studentRoute,
                      (route) => false,
                    );
                  } else if (role == 'Club') {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      clubRoute,
                      (route) => false,
                    );
                  } else if (role == 'Organisation') {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      organisationRoute,
                      (route) => false,
                    );
                  }
                } else {
                  devtools.log('Error');
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  devtools.log("User not found");
                } else if (e.code == 'wrong-password') {
                  devtools.log("Wrong Password");
                }
              }
            },
            child: const Text("Sign in"),
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
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}

roleBased(BuildContext context, User user) {
  return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc('myDocumentID')
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text('Document not found');
        } else if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(data.toString());
        }
        return const Text('LOADING...');
      });
}
