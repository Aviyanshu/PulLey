import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pulley/Colors.dart';
<<<<<<< Updated upstream
import 'package:bcrypt/bcrypt.dart';
=======
>>>>>>> Stashed changes
import 'dart:developer' as devtools show log;

import '../route.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _username;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _role;
  // final Map<String, String> _roles = {
  //   'student': 'student',
  //   'club': 'club',
  //   'organisation': 'organisation',
  // };

  @override
  void initState() {
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _role = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _role.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final List<DropdownMenuItem<String>> _dropdownItems = [
    const DropdownMenuItem(
      value: 'Student',
      child: Text('Student'),
    ),
    const DropdownMenuItem(
      value: 'Club',
      child: Text('Club'),
    ),
    const DropdownMenuItem(
      value: 'Organisation',
      child: Text('Organisation'),
    ),
    // Add more options
  ];
  String? _selectedValue;

  //final CollectionReference rolesCollection =
  //FirebaseFirestore.instance.collection('roles');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('lib/assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 90),
              child: Text(
                'Create\nAccount',
                style: TextStyle(color: darkBlueColor, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Name',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: darkBlueColor),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            cursorColor: darkBlueColor,
                            controller: _username,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please enter a name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: darkBlueColor),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            cursorColor: darkBlueColor,
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            enableSuggestions: false,
                            autocorrect: false,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            cursorColor: darkBlueColor,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: darkBlueColor),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            controller: _password,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please enter a strong password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButton(
                            value: _selectedValue,
                            items: _dropdownItems,
                            iconEnabledColor: darkBlueColor,
                            dropdownColor: darkBlueColor,
                            style: TextStyle(
                                color: lightblueColor,
                                fontWeight: FontWeight.w500),
                            borderRadius: BorderRadius.circular(20),
                            underline: Container(
                              height: 3,
                              color: darkBlueColor,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value;
                                _role.text = value!;
                              });
                            },
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: darkBlueColor,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: darkBlueColor,
                                child: IconButton(
                                    color: lightblueColor,
                                    onPressed: () async {
                                      final username = _username.text;
                                      final email = _email.text;
                                      final password = _password.text;
                                      final role = _role.text;
<<<<<<< Updated upstream
                                      final hashPassword = BCrypt.hashpw(
                                          password, BCrypt.gensalt());
=======
>>>>>>> Stashed changes
                                      try {
                                        final userCredential =
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        );
                                        devtools.log(userCredential.toString());
                                        User user = await FirebaseAuth
                                            .instance.currentUser!;
                                        final CollectionReference
                                            userCollection = FirebaseFirestore
                                                .instance
                                                .collection('Users');
                                        try {
                                          FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(user.uid)
                                              .set({
                                            'username': username,
                                            'email': email,
<<<<<<< Updated upstream
                                            'password': hashPassword,
=======
                                            'password': password,
>>>>>>> Stashed changes
                                            'role': role,
                                          });
                                        } catch (e) {
                                          devtools.log(e.toString());
                                        }
                                        final shouldRegister =
                                            await showDialogBox(context);
                                        if (shouldRegister) {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                            loginRoute,
                                            (route) => false,
                                          );
                                        }
                                      } catch (e) {
                                        devtools.log(e.toString());
                                      }
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    loginRoute,
                                    (route) => false,
                                  );
                                },
                                child: Text(
                                  'Already Registered? Login Here',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: darkBlueColor,
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//     Scaffold(
//       body: Form(
//         key: _formKey,
//         child: Container(
//              decoration: BoxDecoration(
//             image: const DecorationImage(
//               image: AssetImage('lib/assets/register.png'),fit: BoxFit.cover )
//           ),
//             child:SingleChildScrollView(
//               child: Container(
//                  padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.25,right:35,left:35),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextFormField(
//                         decoration: InputDecoration(hintText: 'Name',
//                         enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(width: 2, color: darkBlueColor),
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                              ),

//                       controller: _username,
//                       validator: (value) {
//                         if (value != null && value.isEmpty) {
//                           return 'Please enter a name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height:20),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         hintText: 'Email',
//                          enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(width: 2, color: darkBlueColor),
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                              ),
//                       controller: _email,
//                       keyboardType: TextInputType.emailAddress,
//                       enableSuggestions: false,
//                       autocorrect: false,
//                       validator: (value) {
//                         if (value != null && value.isEmpty) {
//                           return 'Please enter a valid email';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height:20),
//                     TextFormField(
// decoration: InputDecoration(
//                         hintText: 'Password',
//                          enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(width: 2, color: darkBlueColor),
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                              ),
//                       controller: _password,
//                       obscureText: true,
//                       enableSuggestions: false,
//                       autocorrect: false,
//                       validator: (value) {
//                         if (value != null && value.isEmpty) {
//                           return 'Please enter a strong password';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height:20),
//                     const Text('Role:'),
//                     DropdownButton(
//                       value: _selectedValue,
//                       items: _dropdownItems,
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedValue = value;
//                           _role.text = value!;
//                         });
//                       },
//                     ),
//                     TextButton(
//                       onPressed: () async {
//                         final username = _username.text;
//                         final email = _email.text;
//                         final password = _password.text;
//                         final role = _role.text;
//                         try {
//                           final userCredential = await FirebaseAuth.instance
//                               .createUserWithEmailAndPassword(
//                             email: email,
//                             password: password,
//                           );
//                           devtools.log(userCredential.toString());
//                           User user = await FirebaseAuth.instance.currentUser!;
//                           final CollectionReference userCollection =
<<<<<<< Updated upstream
//                               FirebaseFirestore.instance.collection('users');
//                           try {
//                             FirebaseFirestore.instance
//                                 .collection('users')
=======
//                               FirebaseFirestore.instance.collection('Users');
//                           try {
//                             FirebaseFirestore.instance
//                                 .collection('Users')
>>>>>>> Stashed changes
//                                 .doc(user.uid)
//                                 .set({
//                               'username': username,
//                               'email': email,
//                               'password': password,
//                               'role': role,
//                             });
//                           } catch (e) {
//                             devtools.log(e.toString());
//                           }
//                           final shouldRegister = await showDialogBox(context);
//                           if (shouldRegister) {
//                             Navigator.of(context).pushNamedAndRemoveUntil(
//                               loginRoute,
//                               (route) => false,
//                             );
//                           }
//                         } catch (e) {
//                           devtools.log(e.toString());
//                         }
//                       },
//                       child: const Text("Register"),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pushNamedAndRemoveUntil(
//                           loginRoute,
//                           (route) => false,
//                         );
//                       },
//                       child: const Text('Already registered? Login Here'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//       ),
//       backgroundColor: Colors.white,
//     );
//   }
// }

Future<bool> showDialogBox(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: darkBlueColor,
    builder: (context) {
      return AlertDialog(
          title: const Text("Registered"),
          content: const Text("You have been registered successfully"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                login(context);
              },
              child: const Text("OK"),
            ),
          ]);
    },
  ).then((value) => value ?? false);
}

login(context) {
  FirebaseAuth.instance.signOut();
  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
}
