import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pulley/Colors.dart';
import 'package:pulley/perspective/orgPerspective/org_mainpage.dart';
import 'package:pulley/route.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrganisationSettings extends StatefulWidget {
  const OrganisationSettings({super.key});

  @override
  State<OrganisationSettings> createState() => _OrganisationSettingsState();
}

class _OrganisationSettingsState extends State<OrganisationSettings> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;

  onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Settings', style: TextStyle(fontSize: 22)),
            backgroundColor: darkBlueColor,
            foregroundColor: lightblueColor,
            centerTitle: true,
 ),
 backgroundColor: llightblueColor,
        body: Container(
            padding: const EdgeInsets.all(10),
            child: ListView(children: [
              const SizedBox(height: 40),
              Row(children: const [
                // yo chai aba options haru rakhna like account settings and all
                Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 28, 186, 141),
                ),
                SizedBox(width: 10),
                Text('Account Settings',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ]),
              const Divider(height: 20, thickness: 1),
              const SizedBox(height: 10),
              buildAccountOption(context, 'Change Password'),
              buildAccountOption(context, 'Content Settings'),
              buildAccountOption(context, 'Social'),
              buildAccountOption(context, 'Language'),
              buildAccountOption(context, 'Privacy and Security'),

              const SizedBox(height: 40),
              Row(
                children: const [
                  Icon(Icons.volume_up_outlined, color: Colors.blue),
                  SizedBox(width: 10),
                  Text('Notifications',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                ],
              ),
              const Divider(height: 20, thickness: 1),
              const SizedBox(height: 10),
              //buildNotificationOption('Dark Mode', true, ThemeBuilder.of(context).changeTheme());
              buildNotificationOption(
                  'Account Active', valNotify2, onChangeFunction2),
              buildNotificationOption(
                  'Opportunities', valNotify3, onChangeFunction3),
              const SizedBox(height: 50),
              Center(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: (() {
                        signout(context);
                      }),
                      child: const Text('LOG OUT',
                          style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 2.2,
                              color: Colors.black))))
            ])));
  }

  Padding buildNotificationOption(
      String title, bool value, Function onChangeMethod) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600])),
          Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                  activeColor: Colors.blue,
                  trackColor: Colors.grey,
                  value: value,
                  onChanged: (bool newValue) {
                    onChangeMethod(newValue);
                  }))
        ]));
  }

  GestureDetector buildAccountOption(BuildContext context, String title) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(title),
                    content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [Text('Option 1'), Text('Option 2')]),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'))
                    ]);
              });
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600])),
                  const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ])));
  }
}

signout(context) {
  FirebaseAuth.instance.signOut();
  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
}