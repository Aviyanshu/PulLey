import 'package:flutter/material.dart';
import 'package:pulley/Colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:image_picker/image_picker.dart';

class OrganisationHomePage extends StatelessWidget {
  const OrganisationHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: darkBlueColor,
          foregroundColor: llightblueColor,
          centerTitle: false,
          title: const Text('PulLey'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu_rounded))
          ]
          //title: SvgPicture.asset(assets/pulleyname.svg)),
          ),
      body: const PostCard(),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightblueColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(children: [
              const CircleAvatar(
                radius: 16,
                backgroundImage:
                    NetworkImage('https://www.example.com/image.jpg'),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'username',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                              child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            //shrinkWrap: true,
                            children: ["Delete", "Report"]
                                .map((e) => InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                      child: Text(e),
                                    )))
                                .toList(),
                          )));
                },
              )
            ])),
        //image section

        SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyrBSyYXA389y5lA1B4YgrOULYKy-sihIloQ&usqp=CAU',
              fit: BoxFit.cover,
            )),

        //like comment section
        Row(children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline_outlined,
                  color: Colors.red)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.comment),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.send_outlined)),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  )))
        ]),
      ]),
    );
  }
}
