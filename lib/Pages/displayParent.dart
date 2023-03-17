import 'package:circlight/Pages/Admin.dart';

import 'package:circlight/Pages/Admin.dart';
import 'package:circlight/Pages/theme_helper.dart';
import 'package:circlight/Pages/theme_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:circlight/Pages/Parent.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:circlight/Pages/Nav.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'CreateParent.dart';
import 'base_screen.dart';
import 'header_widget.dart';
import 'package:get/get.dart';

class Paretdisplay extends StatefulWidget {
  const Paretdisplay({Key? key}) : super(key: key);

  @override
  State<Paretdisplay> createState() => _Paretdisplay();
}

class _Paretdisplay extends State<Paretdisplay> with TickerProviderStateMixin {
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween, _icon2ColorTween;
  late Animation<Offset> _transTween;
  var CurrentID;
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

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _ColorAnimationController.animateTo(scrollInfo.metrics.pixels / 350);

      _TextAnimationController.animateTo(
          (scrollInfo.metrics.pixels - 350) / 50);
      return true;
    }

    return false;
  }

  Parent parentx = new Parent(
      Name: "",
      Email: "",
      PUserName: "",
      PNationalID: "",
      PJobTitle: "",
      PPhoneNumber: "",
      PAltPhoneNumber: "",
      PNationality: "",
      PRelativeRelation: "");
  String searchname = "";
  @override
  Widget build(BuildContext context) {
    double _headerHeight = 140;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NotificationListener<ScrollNotification>(
          onNotification: _scrollListener,
          child: Container(
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 210,
                        child: Stack(
                          children: [
                            Container(
                              height: _headerHeight,
                              child: HeaderWidget(
                                  _headerHeight, false, Icons.login_rounded),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20, top: 145),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  child: Container(
                                    // padding: const EdgeInsets.only(right: 5),
                                    width: 60,
                                    height: 60,
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 255, 244, 244),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(255, 198, 210, 201)
                                                  .withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                        child: Icon(
                                      Icons.add,
                                      size: 28,
                                      color: Color(0xff57d77a).withOpacity(0.9),
                                    )),
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                      builder: (context) => Nav(
                                        TabValue: 7,
                                        documentId: "",
                                        Name: "",
                                        username: "",
                                        Realtion: "",
                                        email: "",
                                        index: 1,
                                        phone1: "",
                                        phone2: "",
                                        job: "",
                                        ID: "",
                                        header: false,
                                      ),
                                    ));
                                  },
                                ),
                              ),
                            ),
                            Container(
                              //height: 230,
                              padding:
                                  EdgeInsets.only(right: 20, top: 20, left: 20),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: 20, top: 20, left: 20),
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      searchname = value;
                                    });
                                  },
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                      hintText: "..بحث",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade600),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.grey.shade600,
                                        size: 20,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      contentPadding: EdgeInsets.all(8),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade100)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade100))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                      /* this was the float button Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ParentAddform()));
                            },
                            child: const Icon(Icons.add),
                            backgroundColor: const Color(0xff57d77a),
                          ),
                        ),
                      ),*/

                      // width: Get.width,

                      //let's create a common header widget

                      StreamBuilder<QuerySnapshot>(
                        stream: (searchname != "" && searchname != null)
                            ? FirebaseFirestore.instance
                                .collection("Parent")
                                .where("Search", arrayContains: searchname)
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection("Parent")
                                .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            final snap = snapshot.data!.docs;
                            return FutureBuilder(
                                future: Future.wait([
                                  Admin().getAdminID(),
                                  Admin().ParentListView()
                                ]),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: snap.length,
                                      itemBuilder: (context, index) {
                                        //dynamic v = docIDS[index];

                                        return Container(
                                            height: 70,
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(
                                                bottom: 1),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black12),
                                              ),
                                            ),
                                            child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(

                                                      //for profile image

                                                      ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      width: 90,
                                                      height: 100,
                                                      margin: EdgeInsets.only(
                                                          bottom: 10, top: 10),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white60
                                                          //color:
                                                          // Color(0xffD6D6D6),
                                                          ),
                                                      child: Center(
                                                          child: Icon(
                                                              Icons.person,
                                                              size: 40,
                                                              color: Color(
                                                                      0xff57d77a)
                                                                  .withOpacity(
                                                                      0.4))),
                                                    ),
                                                  ),
                                                  //to only show the allowed people to admin

                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 90),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      snap[index]['Name'],
                                                      style: const TextStyle(
                                                        color: const Color(
                                                            0xff0da6c2),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  //container for button

                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    //mainAxisSize:
                                                    // MainAxisSize.max,

                                                    /* mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,*/

                                                    children: <Widget>[
                                                      InkWell(
                                                        // height: 80,

                                                        onTap: () {
                                                          CurrentID = snapshot
                                                              .data![1][index];

                                                          showCupertinoDialog(
                                                              context: context,
                                                              builder:
                                                                  CreateDialog3);
                                                        },

                                                        child: Image.asset(
                                                          'assets/images/delete.jpeg',
                                                          height: 30,
                                                          width: 45,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            // print(docIDS[index]);
                                                            int Tab = 5;
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                                    CupertinoPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Nav(
                                                                TheValue: "",
                                                                index: 1,
                                                                whichpag: 0,
                                                                DropDown: false,
                                                                Confirm: false,
                                                                documentId:
                                                                    snapshot.data![
                                                                            1]
                                                                        [index],
                                                                TabValue: 5,
                                                              ),
                                                            ));
                                                          },
                                                          child: Image.asset(
                                                            'assets/images/edit.jpeg',
                                                            height: 30,
                                                            width: 45,
                                                            fit: BoxFit.contain,
                                                          )),
                                                      InkWell(
                                                        //height: 80,
                                                        onTap: () {
                                                          int Tab = 7;
                                                          Navigator.of(context)
                                                              .push(
                                                                  CupertinoPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Nav(
                                                              documentId:
                                                                  snapshot.data![
                                                                      1][index],
                                                              index: 1,
                                                              Name: "",
                                                              username: "",
                                                              SID: "",
                                                              TabValue: 12,
                                                              header: false,
                                                            ),
                                                          ));
                                                        },
                                                        child: Image.asset(
                                                          'assets/images/addStudent.jpeg',
                                                          height: 30,
                                                          width: 45,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  //this is the same as up but with text
                                                  /* Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/addStudent.png',
                                                  // height: 60,
                                                  // width: 40,
                                                  // fit: BoxFit.contain,
                                                ),
                                                Text('cat')
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/edit.png',
                                                  height: 40,
                                                  // width: 40,
                                                  // fit: BoxFit.contain,
                                                ),
                                                Text('cat')
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/delete.png',
                                                  // height: 60,
                                                  // width: 40,
                                                  // fit: BoxFit.contain,
                                                ),
                                                Text('cat')
                                              ],
                                            ),
                                          ),
                                      
                                          //here end
                                      
                                          Container(
                                              margin: const EdgeInsets.only(right: 20),
                                              alignment: Alignment.centerRight,
                                              child: Row(children: [
                                                ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 14,
                                                            vertical: 8),
                                                        textStyle:
                                                            TextStyle(fontSize: 10)),
                                                    child: Text("Update Parent"),
                                                    onPressed: () {
                                                      // print(docIDS[index]);
                                                      Navigator.of(context)
                                                          .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            StudentAddform(
                                                          documentId: docIDS[index],
                                                        ),
                                                      ));
                                                    }),
                                                ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 14,
                                                            vertical: 8),
                                                        textStyle:
                                                            TextStyle(fontSize: 10)),
                                                    child: Text("Update Parent"),
                                                    onPressed: () {
                                                      // print(docIDS[index]);
                                                      Navigator.of(context)
                                                          .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            StudentAddform(
                                                          documentId: docIDS[index],
                                                        ),
                                                      ));
                                                    }),
                                                ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 14,
                                                            vertical: 8),
                                                        textStyle:
                                                            TextStyle(fontSize: 10)),
                                                    child: Text("Update Parent"),
                                                    onPressed: () {
                                                      // print(docIDS[index]);
                                                      Navigator.of(context)
                                                          .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            StudentAddform(
                                                          documentId: docIDS[index],
                                                        ),
                                                      ));
                                                    })
                                              ])),
                                          //],
                                        ]),*/
                                                ]));
                                      },
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                });
                          } else {
                            return const SizedBox();
                          }
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  height: 75,
                  child: AnimatedBuilder(
                    animation: _ColorAnimationController,
                    builder: (context, child) => AppBar(
                      elevation: 0,
                      iconTheme: IconThemeData(
                        color: _iconColorTween.value,
                      ),
                      automaticallyImplyLeading: false,
                      title: Text(
                        "قائمه أولياء الأمور",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: _iconColorTween.value),
                      ),
                      centerTitle: true,
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
                          color: Colors.white,
                        ),
                      ],
                      backgroundColor: _colorTween.value,
                      titleSpacing: 0.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget CreateDialog3(BuildContext context) {
  //   String Msg = "تجاهل التغييرات";

  //   return CupertinoAlertDialog(
  //     title: Text("حذف ولي أمر"),
  //     content: Text("هل انت متأكد انك تريد حذف ولي الأمر؟"),
  //     actions: [
  //       CupertinoDialogAction(
  //           onPressed: () {
  //             Navigator.push(context,
  //                 CupertinoPageRoute(builder: (context) => Paretdisplay()));
  //           },
  //           child: Text("الغاء")),
  //       CupertinoDialogAction(
  //           isDefaultAction: true,
  //           onPressed: () {
  //             Navigator.pop(context);
  //             parentx.DeleteParent(CurrentID);
  //           },
  //           child: Text("موافق")),
  //     ],
  //   );
  // }

  Widget CreateDialog3(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: const Text('حذف ولي الأمر',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold)),
      content: const Text('هل انت متأكد انك تريد حذف ولي الأمر؟',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);

              parentx.DeleteParent(CurrentID);
            },
            child: const Text("موافق",
                style: TextStyle(
                    color: Color.fromARGB(255, 197, 24, 24),
                    fontWeight: FontWeight.bold))),
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          child: const Text('إلغاء'),
        ),
      ],
    );
  }
}
