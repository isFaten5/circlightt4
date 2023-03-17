import 'package:circlight/Screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/background_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({required this.user, required this.userName});

  String user;
  String userName;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            user,
            style: TextStyle(color: Colors.white38),
          ),
        ),
        body: Column(children: [
          Text(
            userName,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => WelcomeScreen()));
            },
            child: Text(
              "Signout",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          )
        ]),
      ),
    );
  }
}
