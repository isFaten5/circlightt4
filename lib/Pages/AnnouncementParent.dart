import 'package:circlight/Pages/tabs/PrivateAnnoun.dart';
import 'package:circlight/Pages/tabs/PrivateParent.dart';
import 'package:circlight/Pages/tabs/SentAnnouncement.dart';
import 'package:circlight/Pages/tabs/PublicParent.dart';
import 'package:flutter/material.dart';

class AnnouncementParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          /* appBar: AppBar(
              /* title: Text(
            "الاعلانات",
            textAlign: TextAlign.center,
          )*/
              ),*/
          body: Column(children: [
            TabBar(labelColor: Color.fromARGB(255, 0, 0, 0), tabs: [
              Tab(
                icon: Icon(
                  Icons.people,
                  //color: Color.fromARGB(255, 105, 105, 105),
                ),
                text: "الإعلانات العامة",
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  //color: Color.fromARGB(255, 105, 105, 105),
                ),
                text: "الإعلانات الخاصة",
              ),
            ]),
            Expanded(
                child: TabBarView(children: [
              PublicParent(),
              PrivateParent(),
            ]))
          ]),
        ));
  }
}
