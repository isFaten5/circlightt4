import 'package:circlight/Pages/ListReqAdmin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AdminPreviewRequest.dart';
import 'CreateParent.dart';

import 'CreateStudent.dart';

import 'RequestDone.dart';
import 'base_screen.dart';
import 'displayParent.dart';
import 'displayStudent.dart';

import 'edit5.dart';
import 'editStudent.dart';
import 'StudentAssign.dart';
import 'package:circlight/Pages/GenaralSearch.dart';
import 'package:circlight/Pages/StudentAssign.dart';
import 'package:circlight/Pages/viewprofileParent.dart';
import 'package:circlight/Pages/viewprofileStudent.dart';

class Nav extends StatefulWidget {
  final int TabValue;
  final documentId;
  final index;
  final Realtion;
  final Name;
  final username;
  final email;
  final ID;
  final Confirm;
  final nationality;
  final phone1;
  final phone2;
  final job;
  final SID;
  final Blood;
  final Class;
  final TheValue;
  final whichpag;
  final DropDown;
  final header;
  const Nav(
      {super.key,
      this.DropDown,
      required this.TabValue,
      this.documentId,
      this.Blood,
      this.index,
      this.whichpag,
      this.TheValue,
      this.SID,
      this.Class,
      this.Realtion,
      this.Confirm,
      this.ID,
      this.Name,
      this.username,
      this.email,
      this.nationality,
      this.job,
      this.phone1,
      this.phone2,
      this.header});

  @override
  State<Nav> createState() => _Nav();
}

class _Nav extends State<Nav> {
  SetTab() {
    setState(() {
      switch (widget.TabValue) {
        case 0:
          currentScreen = BaseScreen();
          Tab = 0;
          break;
        case 5:
          currentScreen = editparent5(
            documentId: widget.documentId,
            Confirm: false,
            Index: widget.index,
            TheValue: widget.TheValue,
            whichpag: widget.whichpag,
            DropDown: false,
          );
          Tab = 5;
          break;
        case 6:
          //  currentScreen = UpdateStudent(documentId: widget.documentId);
          Tab = 6;
          break;
        case 7:
          currentScreen = Createparent5(
            index: widget.index,
            Name: widget.Name,
            username: widget.username,
            email: widget.email,
            phone1: widget.phone1,
            phone2: widget.phone2,
            Realtion: widget.Realtion,
            header: widget.header,
          );
          Tab = 7;
          break;
        case 8:
          currentScreen = CreateStudent(
            documentId: widget.documentId,
            index: widget.index,
            Name: widget.Name,
            username: widget.username,
            SID: widget.SID,
            header: widget.header,
            nationality: widget.nationality,
            Class: widget.Class,
            Blood: widget.Blood,
          );
          Tab = 8;
          break;
        case 9:
          currentScreen = EditStudent(
            documentId: widget.documentId,
            DropDown: false,
            Confirm: false,
            Index: widget.index,
            TheValue: widget.TheValue,
            whichpag: widget.whichpag,
          );
          Tab = 9;
          break;
        case 10:
          currentScreen = Paretdisplay();
          Tab = 10;
          break;
        case 11:
          currentScreen = Studentdispaly();
          Tab = 11;
          break;

        case 12:
          currentScreen = StudentAssign(
            documentId: widget.documentId,
            index: widget.index,
            Name: widget.Name,
            username: widget.username,
            SID: widget.SID,
            header: widget.header,
            nationality: widget.nationality,
            Class: widget.Class,
            Blood: widget.Blood,
          );
          Tab = 12;
          break;

        case 13:
          currentScreen = GeneralSearch();
          Tab = 13;
          break;

        case 14:
          currentScreen = ViewprofileParent(
            documentId: widget.documentId,
            Confirm: false,
            Index: widget.index,
            TheValue: widget.TheValue,
            whichpag: widget.whichpag,
            DropDown: false,
          );
          Tab = 14;
          break;

        case 15:
          currentScreen = ViewprofileStudent(
            documentId: widget.documentId,
            DropDown: false,
            Confirm: false,
            Index: widget.index,
            TheValue: widget.TheValue,
            whichpag: widget.whichpag,
          );
          Tab = 15;
          break;
        case 16:
          currentScreen = ListReqAdmin();
          Tab = 16;
          break;
        case 17:
          currentScreen = RequestDone(
            documentId: widget.documentId,
          );
          Tab = 17;
          break;
        case 18:
          currentScreen = AdminPreviewRequest(
            documentId: widget.documentId,
          );
          Tab = 18;
          break;
      }
    });
  }

  int _count = 0;
  int Tab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = BaseScreen();

  @override
  Widget build(BuildContext context) {
    final List<Widget> Screens = [
      BaseScreen(),
      Paretdisplay(),
      Studentdispaly(),
    ];
    SetTab();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: BottomAppBar(
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Nav(
                                        TabValue: 16,
                                        // documentId: widget.documentId,
                                      )));
                          Tab = 16;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              //     padding: const EdgeInsets.only(right: 50),
                              child: Align(
                            child: Column(children: [
                              SizedBox(
                                height: 11,
                              ),
                              Image.asset("assets/images/request.png",
                                  width: 25,
                                  height: 25,
                                  color: Tab == 16
                                      ? const Color(0xff0da6c2)
                                      : Colors.grey),
                            ]),
                          )),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            //  padding: const EdgeInsets.only(right: 50),
                            child: Text(
                              'الطلبات',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Tab == 16
                                      ? const Color(0xff0da6c2)
                                      : Colors.grey),
                            ),
                          )

                          // Text
                          // Column
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Nav(
                                        TabValue: 13,
                                        // documentId: widget.documentId,
                                      )));
                          currentScreen = GeneralSearch();
                          Tab = 13;
                        });
                        /* setState(() {
                          currentScreen = Paretdisplay();
                          Tab = 2;
                        });*/
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              //     padding: const EdgeInsets.only(right: 50),
                              child: Align(
                            child: Column(children: [
                              SizedBox(
                                height: 11,
                              ),
                              Image.asset("assets/images/search.png",
                                  width: 25,
                                  height: 25,
                                  color: Tab == 13
                                      ? const Color(0xff0da6c2)
                                      : Color.fromARGB(255, 167, 166, 166)),
                            ]),
                          )),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            //  padding: const EdgeInsets.only(right: 50),
                            child: Text(
                              'البحث',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Tab == 13
                                      ? const Color(0xff0da6c2)
                                      : Colors.grey),
                            ),
                          ),
                          // Text
                          // Column
                        ],
                      ),
                    ),
                  ],
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Nav(
                                    TabValue: 133,
                                    // documentId: widget.documentId,
                                  )));
                      currentScreen = GeneralSearch();
                      Tab = 13;
                    });
                    /* setState(() {
                          currentScreen = Paretdisplay();
                          Tab = 2;
                        });*/
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          //     padding: const EdgeInsets.only(right: 50),
                          child: Align(
                        child: Column(children: [
                          SizedBox(
                            height: 11,
                          ),
                          Image.asset("assets/images/announ.png",
                              width: 25,
                              height: 25,
                              color: Tab == 133
                                  ? const Color(0xff0da6c2)
                                  : Color.fromARGB(255, 167, 166, 166)),
                        ]),
                      )),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        //  padding: const EdgeInsets.only(right: 50),
                        child: Text(
                          'الإعلانات',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Tab == 133
                                  ? const Color(0xff0da6c2)
                                  : Colors.grey),
                        ),
                      ),
                      // Text
                      // Column
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = Studentdispaly();
                            Tab = 1;
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  //    padding:
                                  //        const EdgeInsets.only(right: 50),
                                  child: Align(
                                child: Column(children: [
                                  SizedBox(
                                    height: 11,
                                  ),
                                  Image.asset("assets/images/dashboard.png",
                                      width: 25,
                                      height: 25,
                                      color: Tab == 1
                                          ? const Color(0xff0da6c2)
                                          : Color.fromARGB(255, 167, 166, 166)),
                                ]),
                              )),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                //   padding:
                                //      const EdgeInsets.only(right: 50),
                                child: Text(
                                  'لوحة المتابعة',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Tab == 1
                                          ? const Color(0xff0da6c2)
                                          : Colors.grey),
                                ),
                              )
                            ])),
                    SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Nav(
                                        TabValue: 0,
                                        documentId: widget.documentId,
                                      )));
                          currentScreen = BaseScreen();
                          Tab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              //     padding: const EdgeInsets.only(right: 50),
                              child: Align(
                            child: Column(children: [
                              SizedBox(
                                height: 11,
                              ),
                              Image.asset("assets/images/homepage.png",
                                  width: 25,
                                  height: 25,
                                  color: Tab == 0
                                      ? const Color(0xff0da6c2)
                                      : Color.fromARGB(255, 167, 166, 166)),
                            ]),
                          )),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            //  padding: const EdgeInsets.only(right: 50),
                            child: Text(
                              'الرئيسية',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Tab == 0
                                      ? const Color(0xff0da6c2)
                                      : Colors.grey),
                            ),
                          )
                          // Text
                          // Column
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
