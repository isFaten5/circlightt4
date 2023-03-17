import 'package:circlight/Pages/Admin.dart';

import 'package:circlight/Pages/Student.dart';

import 'package:circlight/Pages/base_screen.dart';

import 'package:circlight/Pages/theme_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:circlight/Pages/Parent.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:circlight/Pages/Nav.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'header_widget.dart';
import 'package:get/get.dart';

class Studentdispaly extends StatefulWidget {
  const Studentdispaly({Key? key}) : super(key: key);

  @override
  State<Studentdispaly> createState() => _Studentdispaly();
}

class _Studentdispaly extends State<Studentdispaly>
    with TickerProviderStateMixin {
  var CurrentID;
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween, _icon2ColorTween;
  late Animation<Offset> _transTween;

  @override
  void initState() {
    getParentsList();
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

  var snackBar = SnackBar(
    content: Text('تم إعادة تعيين ولي الأمر بنجاح'),
  );
  List<String> listParentName = [];
  List<String> listParentId = [];
  // to get all the user name
  Future getParentsList() async {
    await FirebaseFirestore.instance.collection("Parent").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            listParentId.add(document.id);
            // print("parentids are${listParentId}");
            listParentName.add(document["UserName"]);
          }),
        );
  }

  Future assignParentToStudent({String? studentId, String? parentId}) async {
    print("studentid is${studentId}");
    print("parentid is${parentId}");
    await FirebaseFirestore.instance
        .collection("Student")
        .doc(studentId)
        .set({"ParentId": "${parentId.toString()}"}, SetOptions(merge: true));
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

  Student Studentx = new Student(
    Name: "",
    Class: "",
    SNationalID: "",
    SNationality: "",
    SUserName: "",
    SBloodType: "",
  );
  String searchname = "";
  @override
  Widget build(BuildContext context) {
    double _headerHeight = 150;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                      height: 140,
                      child: Stack(
                        children: [
                          Container(
                            height: _headerHeight,
                            child: HeaderWidget(
                                _headerHeight,
                                false,
                                Icons
                                    .login_rounded), //let's create a common header widget
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //height: 230,
                      padding: EdgeInsets.only(right: 20, top: 20, left: 20),
                      child: Padding(
                        padding: EdgeInsets.only(right: 20, top: 20, left: 20),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchname = value;
                            });
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                              hintText: "..بحث",
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              contentPadding: EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100))),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //for the button
                    /* Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ParentAddform()));
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text(
                              ' اضافه ولي امر + ',
                              style: TextStyle(
                                  fontSize: 15,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),*/
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
                              .collection("Student")
                              .where("Search", arrayContains: searchname)
                              .snapshots()
                          : FirebaseFirestore.instance
                              .collection("Student")
                              .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          final snap = snapshot.data!.docs;
                          return FutureBuilder(
                              future: Future.wait([
                                Admin().getAdminID(),
                                Admin().StudentListveiw()
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
                                      Map<String, dynamic>? mapid = snap[index]
                                          .data() as Map<String, dynamic>;
                                      // print("mapcheck ${mapid}");
                                      String? adminId = mapid['AdminID'];

                                      String? adminIdnew = snapshot.data![0][0];
                                      bool isAdmin = adminIdnew == adminId;
                                      //(snap[index]['AdminID'] == AdminID[0])
                                      return isAdmin
                                          ? Container(
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
                                                      decoration:
                                                          BoxDecoration(),
                                                    ),

                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Container(
                                                        width: 90,
                                                        height: 100,
                                                        margin: EdgeInsets.only(
                                                            bottom: 10,
                                                            top: 10),
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Colors.white60
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
                                                    ), //to only show the allowed people to admin

                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 90),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        snap[index]['Name'],
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xff0da6c2),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    //container for button

                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        /////////////////////////
                                                        InkWell(
                                                            // height: 80,
                                                            onTap: () {
                                                              CurrentID =
                                                                  snapshot.data![
                                                                      1][index];
                                                              showCupertinoDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      CreateDialog3);
                                                            },
                                                            child: Image.asset(
                                                              'assets/images/delete.png',
                                                              height: 30,
                                                              width: 45,
                                                              fit: BoxFit
                                                                  .contain,
                                                            )),
                                                        InkWell(
                                                            onTap: () {
                                                              // print(docIDS[index]);

                                                              int Tab = 8;
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                                      CupertinoPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Nav(
                                                                  documentId:
                                                                      snapshot.data![
                                                                              1]
                                                                          [
                                                                          index],
                                                                  TabValue: 9,
                                                                  TheValue: "",
                                                                  whichpag: 0,
                                                                  DropDown:
                                                                      false,
                                                                  Confirm:
                                                                      false,
                                                                  index: 1,
                                                                ),
                                                              ));
                                                            },
                                                            child: Image.asset(
                                                              'assets/images/edit.png',
                                                              height: 30,
                                                              width: 40,
                                                              fit: BoxFit
                                                                  .contain,
                                                            )),
                                                        /////////////////////////
                                                        InkWell(
                                                          //height: 80,
                                                          onTap: () {
                                                            showModalBottomSheet<
                                                                void>(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return ListView
                                                                    .builder(
                                                                        itemCount:
                                                                            listParentName
                                                                                .length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index2) {
                                                                          return ListTile(
                                                                              onTap: () async {
                                                                                await assignParentToStudent(studentId: snap[index].id, parentId: listParentId[index2]);
                                                                                Navigator.pop(context);
                                                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                              },
                                                                              title: Text(listParentName[index2]));
                                                                        });
                                                              },
                                                            );

                                                            // int Tab = 7;
                                                            // Navigator.of(context)
                                                            //     .push(
                                                            //         CupertinoPageRoute(
                                                            //   builder:
                                                            //       (context) =>
                                                            //           Nav(
                                                            //     documentId:
                                                            //         snapshot.data![
                                                            //             1][index],
                                                            //     index: 1,
                                                            //     Name: "",
                                                            //     username: "",
                                                            //     SID: "",
                                                            //     TabValue: 8,
                                                            //     header: false,
                                                            //   ),
                                                            // ));
                                                          },
                                                          child: Image.asset(
                                                            'assets/icons/reassign.png',
                                                            height: 30,
                                                            width: 40,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ]))
                                          : const SizedBox();
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
                height: 55,
                child: AnimatedBuilder(
                  animation: _ColorAnimationController,
                  builder: (context, child) => AppBar(
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
                                "قائمه الطلاب",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: _iconColorTween.value),
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
                        color: Colors.white,
                      ),
                    ],
                    backgroundColor: _colorTween.value,
                    elevation: 0,
                    titleSpacing: 0.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CreateDialog3(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: const Text('حذف الطالب',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold)),
      content: const Text('هل انت متأكد انك تريد حذف الطالب؟',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);

              Studentx.DeleteStudent(CurrentID);
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
