/* import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class BookmarkButton extends StatefulWidget {
  final String postId;

  BookmarkButton({@required this.postId});

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool _isBookmarked = false;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isBookmarked ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border),
      onPressed: () {
        setState(() {
          _isBookmarked = !_isBookmarked;
          if (_isBookmarked) {
            _database
                .reference()
                .child("bookmarks")
                .child(widget.postId)
                .set(true);
          } else {
            _database
                .reference()
                .child("bookmarks")
                .child(widget.postId)
                .set(null);
          }
        });
      },
    );
  }
}
 */