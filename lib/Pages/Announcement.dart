import 'package:circlight/Pages/Nav.dart';

import 'package:circlight/Pages/tabs/PrivateAnnoun.dart';

import 'package:circlight/Pages/tabs/PublicAnnoun.dart';

import 'package:circlight/Pages/tabs/SentAnnouncement.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _Announcement();
}

class _Announcement extends State<Announcement> with TickerProviderStateMixin {
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween, _icon2ColorTween;
  late Animation<Offset> _transTween;

  @override
  void initState() {
    _ColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_ColorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.white, end: Colors.grey)
        .animate(_ColorAnimationController);
    _icon2ColorTween =
        ColorTween(begin: Colors.white, end: const Color(0xff42c98d))
            .animate(_ColorAnimationController);

    _TextAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_TextAnimationController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          /* appBar: AppBar(
            iconTheme: IconThemeData(
              color: _iconColorTween.value,
            ),
            automaticallyImplyLeading: false,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 195,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "الاعلانات",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Color(0xff42c98d)),
                      ),
                    ),
                  ),
                ]),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Nav(
                                TabValue: 0,
                                documentId: "",
                              )));
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: _iconColorTween.value,
                ),
                color: Colors.grey,
              ),
            ],
            backgroundColor: _colorTween.value,
            elevation: 0,
            titleSpacing: 0.0,
          ),*/
          body: Column(children: [
            TabBar(labelColor: Color.fromARGB(255, 0, 0, 0), tabs: [
              Tab(
                icon: Icon(
                  Icons.people,
                  // color: Color(0xff0da6c2),
                ),
                text: "الإعلانات العامة",
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  //color: Color(0xff0da6c2),
                ),
                text: "الإعلانات الخاصة",
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  // color: Color(0xff0da6c2),
                ),
                text: "الإعلانات المرسلة",
              ),
            ]),
            Expanded(
                child: TabBarView(children: [
              PublicAnnoun(),
              PrivateAnnoun(),
              SentAnnouncement(),
            ]))
          ]),
        ));
  }
}
