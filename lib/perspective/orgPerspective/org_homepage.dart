import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pulley/Colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/image.dart';
<<<<<<< Updated upstream
import 'package:pulley/Extras/searchscreen.dart';

enum MenuAction { delete, edit }
=======
import 'package:pulley/Extras/comments.dart';
import 'package:pulley/Extras/likeanimation.dart';
import 'package:pulley/Extras/searchscreen.dart';
>>>>>>> Stashed changes

class OrganisationHomePage extends StatelessWidget {
  //const OrganisationHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: darkBlueColor,
          foregroundColor: llightblueColor,
          centerTitle: false,
<<<<<<< Updated upstream
          title: const Text('PulLey'),
=======
          title: Text('PulLey'),
>>>>>>> Stashed changes
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                })
          ]),
      backgroundColor: llightblueColor,
      body: _buildVacancyList(),
    );
  }
}

Widget _buildVacancyList() {
  bool _isPressed = false;
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('_Vacancy_').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: const CircularProgressIndicator(),
        );
      }
      List<QueryDocumentSnapshot<Object?>>? vacancies = snapshot.data?.docs;
      return ListView.builder(
        itemCount: vacancies?.length,
        itemBuilder: (BuildContext context, int index) {
<<<<<<< Updated upstream
          String userID = (vacancies![index].data() as dynamic)['user'];
          String post = (vacancies[index].data() as dynamic)['post'];
=======
          String post = (vacancies![index].data() as dynamic)['post'];
>>>>>>> Stashed changes
          String qualifications =
              (vacancies[index].data() as dynamic)['qualifications'];
          String deadline = (vacancies[index].data() as dynamic)['deadline'];
          String description =
              (vacancies[index].data() as dynamic)['description'];
          String salary = (vacancies[index].data() as dynamic)['salary'];
<<<<<<< Updated upstream
          String status = (vacancies[index].data() as dynamic)['status'];
          final documentID = vacancies[index].id;
          User user = FirebaseAuth.instance.currentUser!;
          if (status == 'notFull') {
            if (user.uid == userID) {
              return Container(
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: ListTile(
                  title: Text(
                    post,
                    style: (TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: darkBlueColor)),
                  ),
                  subtitle: Text(
                      "Qualifications: $qualifications\nDeadline: $deadline\nDescription: $description\nSalary: $salary\n"),
                  trailing: PopupMenuButton<MenuAction>(
                    onSelected: (value) async {
                      switch (value) {
                        case MenuAction.delete:
                          await FirebaseFirestore.instance
                              .collection('_Events_')
                              .doc(documentID)
                              .update({'status': 'Full'});
                      }
                    },
                    itemBuilder: (context) {
                      return const [
                        PopupMenuItem<MenuAction>(
                          value: MenuAction.delete,
                          child: Text('Delete'),
                        )
                      ];
                    },
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: darkBlueColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            } else {
              return Container(
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: ListTile(
                  title: Text(
                    post,
                    style: (TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: darkBlueColor)),
                  ),
                  subtitle: Text(
                      "Qualifications: $qualifications\nDeadline: $deadline\nDescription: $description\nSalary: $salary\n"),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: darkBlueColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }
          } else {
            return Container();
          }
=======
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),

//codes  for icons
            /*children: <Widget>[
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.favorite, color: darkBlueColor),
                        Icon(Icons.comment),
                      ],
                    ),
                  ),
                )
              ],  */

            /*Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.favorite, color: Colors.red),
                    SizedBox(width: 16.0),
                    Icon(Icons.comment),
                    SizedBox(width: 16.0),
                    Icon(Icons.share),
                  ],
                ),
              ),*/

            // shape: RoundedRectangleBorder(
            //  side: BorderSide(width: 2, color: darkBlueColor),
            // borderRadius: BorderRadius.circular(10),
            // ),
            child: ListTile(
              //leading: CircleAvatar (
              //backgroundImage: NetworkImage (user.profimage ))
              title: Text(
                post,
                style: (const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: darkBlueColor)),
              ),
              subtitle: Text(
                  "Qualifications: $qualifications\nDeadline: $deadline\nDescription: $description\nSalary: $salary"),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: darkBlueColor),
                borderRadius: BorderRadius.circular(10),
              ),
              //trailing: Icon(Icons.comment, color: darkBlueColor),
              onTap: () {
                /* Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => CommentsScreen(postId: postId)),//esma post ko id firebase bata line how 

                ); */
              },

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  /*  LikeAnimation(
                    isAnimating: snap['likes'].contains(user.uid),
                    smallLike: true, */
                  IconButton(
                      icon: Icon(Icons.favorite_border), onPressed: () {}),
                  IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
>>>>>>> Stashed changes
        },
      );
    },
  );

<<<<<<< Updated upstream
  comparator(
      QueryDocumentSnapshot<Object?> A, QueryDocumentSnapshot<Object?> B) {}
}
=======
/* class BookmarkButton extends StatefulWidget {
  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isBookmarked = !_isBookmarked;
        });
      },
      child: Icon(
        _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: Colors.white,
      ),
    );
  }
}
 */
>>>>>>> Stashed changes
